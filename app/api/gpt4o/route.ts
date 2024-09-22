import { NextResponse } from 'next/server';
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export async function POST(request: Request) {
  const { prompt } = await request.json();

  try {
    const response = await openai.chat.completions.create({
      model: 'gpt-4',
      messages: [
        { role: 'system', content: 'You are a helpful assistant.' },
        { role: 'user', content: prompt },
      ],
      temperature: 0.7,
      max_tokens: 500,
      stream: false,
    });

    return NextResponse.json({ message: response.choices[0].message.content });
  } catch (error) {
    console.error('Failed to communicate with GPT-4 API:', error);
    return NextResponse.json({ error: 'Failed to communicate with GPT-4 API' }, { status: 500 });
  }
}