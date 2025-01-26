import { NextResponse } from 'next/server';
import OpenAI from 'openai';

// IMPORTANT: Set the runtime to edge
export const runtime = 'edge';

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const prompt = searchParams.get('prompt');
    const apiKey = process.env.OPENAI_API_KEY;

    if (!apiKey) {
      return NextResponse.json(
        { message: 'OpenAI API key is not configured' },
        { status: 500 }
      );
    }

    if (!prompt) {
      return NextResponse.json(
        { message: 'Prompt is required' },
        { status: 400 }
      );
    }

    const openai = new OpenAI({ apiKey });
    const encoder = new TextEncoder();
    
    const stream = new ReadableStream({
      async start(controller) {
        try {
          const response = await openai.chat.completions.create({
            model: 'gpt-4',
            messages: [{ role: 'user', content: prompt }],
            stream: true,
          });

          for await (const chunk of response) {
            const content = chunk.choices[0]?.delta?.content || '';
            if (content) {
              controller.enqueue(
                encoder.encode(`data: ${JSON.stringify({
                  choices: [{ delta: { content } }]
                })}\n\n`)
              );
            }
          }
          
          controller.enqueue(encoder.encode('data: [DONE]\n\n'));
          controller.close();
        } catch (error) {
          const errorMessage = error instanceof Error ? error.message : 'Internal server error';
          controller.enqueue(
            encoder.encode(`data: ${JSON.stringify({ error: errorMessage })}\n\n`)
          );
          controller.close();
        }
      },
    });

    return new Response(stream, {
      headers: {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
      },
    });
  } catch (error) {
    console.error('API route error:', error);
    return NextResponse.json(
      { message: error instanceof Error ? error.message : 'Internal server error' },
      { status: 500 }
    );
  }
} 