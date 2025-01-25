import OpenAI from 'openai';

// Create an OpenAI API client
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY || '',
});

// IMPORTANT: Set the runtime to edge
export const runtime = 'edge';

export async function POST(req: Request) {
  try {
    const { messages } = await req.json();

    // Create the stream
    const response = await openai.chat.completions.create({
      model: 'gpt-4o',
      stream: true,
      messages: [
        {
          role: "system",
          content: `You are a highly knowledgeable expert in wind energy and wind farms. 
          Format your responses using markdown with the following structure:
          1. Start with a clear, concise introduction
          2. Use ## for main section headings
          3. Use bullet points or numbered lists for key points
          4. Use **bold** for important terms
          5. Include a brief summary at the end
          6. Keep paragraphs short and focused
          7. Use technical terms but explain them clearly
          8. Format equations or measurements properly
          
          Focus on technical accuracy while maintaining accessibility.
          Always structure your response in a clear, visually appealing way.`
        },
        ...messages
      ],
    });

    // Create a TransformStream to convert the response to raw text
    const stream = new TransformStream({
      async transform(chunk, controller) {
        const text = chunk.choices[0]?.delta?.content || '';
        if (text) {
          controller.enqueue(new TextEncoder().encode(text));
        }
      }
    });

    // Pipe the response through our transform stream
    response.pipe(stream);

    return new Response(stream.readable, {
      headers: {
        'Content-Type': 'text/plain; charset=utf-8',
      },
    });
  } catch (error) {
    console.error('Error in AI route:', error);
    return new Response(
      JSON.stringify({ error: 'Error processing your request' }), 
      { status: 500 }
    );
  }
} 