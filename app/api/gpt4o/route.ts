import { NextResponse } from 'next/server';
import OpenAI from 'openai';

export const runtime = 'edge';

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export async function POST(request: Request) {
  const startTime = Date.now();
  console.log('🚀 [GPT-4O API] Request received');
  
  try {
    const { prompt } = await request.json();
    console.log(`📝 [GPT-4O API] Prompt length: ${prompt.length} chars`);
    const encoder = new TextEncoder();
    let totalTokens = 0;
    let chunkCount = 0;

    const stream = new ReadableStream({
      async start(controller) {
        try {
          console.log('🔄 [GPT-4O API] Initializing stream...');
          const response = await openai.chat.completions.create({
            model: 'gpt-4o',
            messages: [
              { role: 'system', content: 'You are a helpful assistant.' },
              { role: 'user', content: prompt },
            ],
            temperature: 0.7,
            stream: true,
          });

          console.log('✅ [GPT-4O API] Stream connected successfully');

          for await (const chunk of response) {
            const content = chunk.choices[0]?.delta?.content || '';
            if (content) {
              chunkCount++;
              totalTokens += content.length / 4; // Rough token estimation
              
              if (chunkCount % 50 === 0) {
                console.log(`📊 [GPT-4O API] Progress - Chunks: ${chunkCount}, Est. Tokens: ${Math.round(totalTokens)}`);
              }

              controller.enqueue(
                encoder.encode(`data: ${JSON.stringify({
                  choices: [{ delta: { content } }]
                })}\n\n`)
              );
            }
          }
          
          const duration = ((Date.now() - startTime) / 1000).toFixed(2);
          console.log(`
🏁 [GPT-4O API] Stream completed
📊 Stats:
- Duration: ${duration}s
- Total chunks: ${chunkCount}
- Est. tokens: ${Math.round(totalTokens)}
- Avg chunks/sec: ${Math.round(chunkCount / parseFloat(duration))}
`);

          controller.enqueue(encoder.encode('data: [DONE]\n\n'));
          controller.close();
        } catch (error) {
          console.error('❌ [GPT-4O API] Stream error:', error);
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
    console.error('❌ [GPT-4O API] Route error:', error);
    return NextResponse.json(
      { message: error instanceof Error ? error.message : 'Internal server error' },
      { status: 500 }
    );
  }
}