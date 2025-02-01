'use client';

import { useState, useEffect, useRef } from 'react';
import { Send } from 'lucide-react';

type StreamError = {
  message: string;
  code?: string;
};

export default function ChatComponent() {
  const [prompt, setPrompt] = useState('');
  const [displayedResponse, setDisplayedResponse] = useState('');
  const [fullResponse, setFullResponse] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<StreamError | null>(null);
  const responseRef = useRef<HTMLDivElement>(null);
  const eventSourceRef = useRef<EventSource | null>(null);
  const typewriterTimeoutRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    if (responseRef.current) {
      responseRef.current.scrollTop = responseRef.current.scrollHeight;
    }
  }, [displayedResponse]);

  // Typewriter effect
  useEffect(() => {
    if (fullResponse.length > displayedResponse.length) {
      if (typewriterTimeoutRef.current) {
        clearTimeout(typewriterTimeoutRef.current);
      }
      
      typewriterTimeoutRef.current = setTimeout(() => {
        setDisplayedResponse(fullResponse.slice(0, displayedResponse.length + 1));
      }, 20); // Adjust speed here (lower = faster)
    }
  }, [fullResponse, displayedResponse]);

  // Cleanup
  useEffect(() => {
    return () => {
      if (eventSourceRef.current) {
        eventSourceRef.current.close();
      }
      if (typewriterTimeoutRef.current) {
        clearTimeout(typewriterTimeoutRef.current);
      }
    };
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!prompt.trim() || isLoading) return;

    if (eventSourceRef.current) {
      eventSourceRef.current.close();
    }
    if (typewriterTimeoutRef.current) {
      clearTimeout(typewriterTimeoutRef.current);
    }

    setIsLoading(true);
    setFullResponse('');
    setDisplayedResponse('');
    setError(null);

    try {
      const params = new URLSearchParams({ prompt });
      const eventSource = new EventSource(`/api/ai?${params}`);
      eventSourceRef.current = eventSource;

      eventSource.onmessage = (event) => {
        try {
          if (event.data === '[DONE]') {
            eventSource.close();
            setIsLoading(false);
            return;
          }

          const data = JSON.parse(event.data);
          if (data.error) {
            throw new Error(data.error);
          }

          const content = data.choices?.[0]?.delta?.content || '';
          if (content) {
            setFullResponse(prev => prev + content);
          }
        } catch (err) {
          if (err instanceof Error && err.message !== 'Unexpected end of JSON input') {
            setError({ message: err.message });
          }
        }
      };

      eventSource.onerror = (error) => {
        console.error('EventSource error:', error);
        eventSource.close();
        setIsLoading(false);
        setError({ message: 'Connection error occurred' });
      };

    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'An unexpected error occurred';
      setError({ message: errorMessage });
      console.error('Streaming error:', errorMessage);
      setIsLoading(false);
    }
  };

  return (
    <div className="w-full max-w-4xl mx-auto p-4 space-y-4">
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="flex gap-4">
          <input
            type="text"
            value={prompt}
            onChange={(e) => setPrompt(e.target.value)}
            placeholder="Ask me anything..."
            className="flex-1 px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            disabled={isLoading}
          />
          <button
            type="submit"
            disabled={isLoading || !prompt.trim()}
            className="px-6 py-2 rounded-lg bg-blue-500 text-white hover:bg-blue-600 transition-colors disabled:opacity-50 flex items-center gap-2"
          >
            <Send className="w-4 h-4" />
            {isLoading ? 'Thinking...' : 'Send'}
          </button>
        </div>
      </form>

      {error && (
        <div className="rounded-lg border border-red-500 p-4 bg-red-50 text-red-700">
          {error.message}
        </div>
      )}

      <div 
        ref={responseRef}
        className="rounded-lg border border-gray-200 p-6 min-h-[200px] max-h-[500px] overflow-y-auto"
      >
        {displayedResponse || isLoading ? (
          <div className="prose prose-sm max-w-none whitespace-pre-wrap">
            {displayedResponse}
            {isLoading && (
              <span className="inline-block w-2 h-4 ml-1 bg-blue-500 animate-pulse" />
            )}
          </div>
        ) : (
          <div className="text-gray-400 text-center">
            Ask me a question and I'll help you out!
          </div>
        )}
      </div>
    </div>
  );
} 