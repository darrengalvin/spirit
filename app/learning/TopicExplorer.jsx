'use client';

import React, { useState, useEffect, useRef } from 'react';
import { ChevronRight, Video, BookOpen, FileDown, Search, Menu, X, MessageSquare, Lightbulb, ArrowRight, Sparkles, BookOpenIcon, ArrowUpRight, Link, ExternalLink, Clock, Sun, Moon } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { flushSync } from 'react-dom';

// Quick access topics that appear below search
const quickTopics = [
  {
    id: 'foundations',
    title: 'Foundations',
    preview: 'Learn about different types of wind turbine foundations',
    relatedTopics: ['Monopile', 'Jacket', 'Floating'],
  },
  {
    id: 'turbines',
    title: 'Wind Turbine Generators',
    preview: 'Explore how wind turbines convert wind into electricity',
    relatedTopics: ['Blade Design', 'Generator Types', 'Control Systems'],
  },
  {
    id: 'environmental',
    title: 'Environmental Impact',
    preview: 'Understand effects on marine life and ecosystems',
    relatedTopics: ['Marine Life', 'Bird Migration', 'Noise Impact'],
  },
  {
    id: 'maintenance',
    title: 'Operations & Maintenance',
    preview: 'Discover how wind farms are maintained',
    relatedTopics: ['Preventive Maintenance', 'Remote Monitoring', 'Safety Protocols'],
  },
];

// Recent trending topics
const trendingTopics = [
  "Latest innovations in floating wind farms",
  "Impact of offshore wind on fishing industry",
  "New blade materials research",
  "Wind farm worker safety developments",
  "Advances in wind forecasting",
];

// Sample content data structure
const contentDatabase = {
  'foundations': {
    title: 'Wind Farm Foundations',
    subtitle: 'Understanding the Critical Support Structures',
    sections: [
      {
        title: 'Overview',
        content: `Foundations play a crucial role in the longevity and efficiency of offshore wind farms. They need to withstand harsh marine conditions, provide stability for the turbines, and last for the operational life of the wind farm, typically 20-25 years.

The design, selection, and installation of foundations are critical aspects of offshore wind farm projects. Different types of foundations are used depending on water depth, seabed conditions, and turbine size.`
      },
      {
        title: 'Onshore Wind Farm Foundations',
        content: `Onshore wind turbines typically use gravity foundations. These foundations are large, reinforced concrete structures designed to support the turbine's weight and resist overturning forces. The process of building a gravity foundation involves:

1. Excavating the site
2. Pouring a concrete base
3. Constructing a reinforced steel frame (about 105 tonnes of steel rebar)
4. Filling the frame with concrete (around 1700 tonnes)
5. Backfilling with aggregate for additional weight and support`
      },
      {
        title: 'Offshore Wind Farm Foundations',
        content: `Offshore wind turbines require specialized foundations to withstand marine conditions. The most common types are:

1. Monopile foundations: Single steel tubes driven into the seabed
2. Jacket foundations: Steel lattice structures suitable for deeper waters
3. Floating foundations: Advanced systems for deep-water installations
4. Gravity-based foundations: Concrete structures for shallow waters`
      }
    ],
    sources: [
      {
        title: "Offshore Wind Foundation Handbook",
        url: "https://example.com/handbook",
        publisher: "Wind Energy Institute",
        year: 2023
      },
      {
        title: "Marine Engineering Standards",
        url: "https://example.com/standards",
        publisher: "International Maritime Organization",
        year: 2022
      }
    ],
    relatedQuestions: [
      "What are the main types of offshore wind foundations?",
      "How deep can monopile foundations be installed?",
      "What challenges exist in floating foundation design?",
      "How are foundations maintained underwater?"
    ],
    keyPoints: [
      "Foundations must withstand extreme weather conditions",
      "Different types suit different water depths",
      "Installation methods vary by foundation type",
      "Regular maintenance is crucial for longevity"
    ],
    citations: [
      {
        text: "Monopile foundations remain the most common choice for depths up to 30 meters",
        source: "Offshore Wind Foundation Handbook",
        page: "23"
      },
      {
        text: "Foundation costs can represent up to 25% of total project costs",
        source: "Marine Engineering Standards",
        page: "156"
      }
    ]
  },
  // ... (add more content for other topics)
};

// Add sample library data
const libraryConversations = [
  {
    id: 'foundations-chat',
    title: 'Foundations of windfarms',
    preview: 'Wind farm foundations are critical structures designed to support wind turbines...',
    timestamp: '8 minutes ago',
    icon: <BookOpenIcon size={16} className="text-blue-500" />
  },
  {
    id: 'job-opportunities',
    title: 'Tell me about wind farm job opportunities',
    preview: 'Wind farm job opportunities in the UK are diverse and growing...',
    timestamp: '30 minutes ago',
    icon: <Lightbulb size={16} className="text-green-500" />
  },
  {
    id: 'career-path',
    title: 'I want to work in the windfarm industry',
    preview: 'Working in the windfarm industry is indeed a promising career choice...',
    timestamp: '45 minutes ago',
    icon: <BookOpenIcon size={16} className="text-purple-500" />
  }
];

const TopicExplorer = () => {
  // Audio sources with their display names
  const audioSources = [
    {
      url: 'https://firebasestorage.googleapis.com/v0/b/yourcaio-649fe.firebasestorage.app/o/windfarm-turbine.wav?alt=media&token=a2ea02d1-8af8-4cac-bad8-8e24cf4ec644',
      name: 'Wind Farm Turbine'
    },
    {
      url: 'https://firebasestorage.googleapis.com/v0/b/yourcaio-649fe.firebasestorage.app/o/windfarm-turbine-walkbye.wav?alt=media&token=187421ec-ae6f-43a1-be14-3cc4105aba2f',
      name: 'Turbine Walk-by'
    },
    {
      url: 'https://firebasestorage.googleapis.com/v0/b/yourcaio-649fe.firebasestorage.app/o/wind-turbine-blades.wav?alt=media&token=cd2ed807-515f-402d-8b45-1c5a67d3c143',
      name: 'Turbine Blades'
    }
  ];

  // Create refs for all audio sources
  const audioRefs = useRef(audioSources.map(source => new Audio(source.url)));
  const [currentAudioIndex, setCurrentAudioIndex] = useState(0);

  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [currentTopic, setCurrentTopic] = useState(null);
  const [searchHistory, setSearchHistory] = useState([]);
  const [selectedQuickTopic, setSelectedQuickTopic] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isDarkMode, setIsDarkMode] = useState(true);
  const [showProTooltip, setShowProTooltip] = useState(false);
  const [proSearchesLeft, setProSearchesLeft] = useState(3);
  const [isPro, setIsPro] = useState(false);
  const [currentQuestion, setCurrentQuestion] = useState('');
  const [selectedTopic, setSelectedTopic] = useState(null);
  const [isFollowUpCollapsed, setIsFollowUpCollapsed] = useState(false);
  const [messages, setMessages] = useState([]);
  const [isTyping, setIsTyping] = useState(false);
  const [isGeneratingPairs, setIsGeneratingPairs] = useState(false);
  const [explorationPairs, setExplorationPairs] = useState([]);
  const [loadingStage, setLoadingStage] = useState(0);
  const [content, setContent] = useState('');
  const [fullResponse, setFullResponse] = useState('');
  const [displayedResponse, setDisplayedResponse] = useState('');
  const [error, setError] = useState(null);
  const eventSourceRef = React.useRef(null);
  const typewriterTimeoutRef = React.useRef(null);
  const [isAudioPlaying, setIsAudioPlaying] = useState(false);

  useEffect(() => {
    // Check system preference on mount
    if (typeof window !== 'undefined') {
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      setIsDarkMode(prefersDark);
    }
  }, []);

  // Update the audio effect
  useEffect(() => {
    const playAudio = async () => {
      if (isLoading) {
        try {
          // Pick a random audio source
          const randomIndex = Math.floor(Math.random() * audioSources.length);
          setCurrentAudioIndex(randomIndex);
          
          const currentAudio = audioRefs.current[randomIndex];
          
          // Ensure audio is loaded
          if (currentAudio.readyState < 4) {
            await new Promise((resolve) => {
              currentAudio.addEventListener('canplaythrough', resolve, { once: true });
              currentAudio.load();
            });
          }
          
          currentAudio.loop = true;
          currentAudio.volume = 0.3;
          await currentAudio.play();
          setIsAudioPlaying(true);
        } catch (e) {
          console.log('Audio play failed:', e);
        }
      } else {
        // Stop all audio when loading ends
        audioRefs.current.forEach(audio => {
          audio.pause();
          audio.currentTime = 0;
        });
        setIsAudioPlaying(false);
      }
    };

    playAudio();

    // Cleanup
    return () => {
      audioRefs.current.forEach(audio => {
        audio.pause();
        audio.currentTime = 0;
      });
      setIsAudioPlaying(false);
    };
  }, [isLoading]);

  // Update the typewriter effect to be more responsive
  useEffect(() => {
    if (fullResponse.length > displayedResponse.length) {
      if (typewriterTimeoutRef.current) {
        clearTimeout(typewriterTimeoutRef.current);
      }
      // Display content immediately as it arrives
      setDisplayedResponse(fullResponse);
    }
  }, [fullResponse, displayedResponse]);

  // Add cleanup effect
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

  const toggleTheme = () => {
    setIsDarkMode(!isDarkMode);
  };

  // Theme classes
  const themeClasses = {
    // Base backgrounds
    mainBg: isDarkMode ? 'bg-spirit-darkBg' : 'bg-spirit-lightBg',
    headerBg: isDarkMode ? 'bg-spirit-darkBg/90 backdrop-blur-sm' : 'bg-spirit-lightMuted/50 backdrop-blur-sm',
    sidebarBg: isDarkMode ? 'bg-spirit-darkBg' : 'bg-spirit-lightMuted/30',
    cardBg: isDarkMode ? 'bg-spirit-muted/30' : 'bg-white',
    inputBg: isDarkMode ? 'bg-spirit-muted/20' : 'bg-spirit-lightMuted/70',
    
    // Borders
    border: isDarkMode ? 'border-spirit-border' : 'border-spirit-lightBorder',
    
    // Text colors
    textPrimary: isDarkMode ? 'text-white' : 'text-spirit-darkText',
    textSecondary: isDarkMode ? 'text-spirit-accent/90' : 'text-spirit-darkText/80',
    textTertiary: isDarkMode ? 'text-spirit-accent/60' : 'text-spirit-darkText/60',
    
    // Hover states
    hoverBg: isDarkMode ? 'hover:bg-spirit-muted/40' : 'hover:bg-spirit-lightMuted',
    
    // Special elements
    chipBg: isDarkMode ? 'bg-spirit-muted/20' : 'bg-spirit-lightMuted/80',
    gradientFrom: isDarkMode ? 'from-spirit-darkBg' : 'from-spirit-lightMuted',
    gradientVia: isDarkMode ? 'via-spirit-darkBg' : 'via-spirit-lightMuted',

    // Shadows for light mode
    cardShadow: isDarkMode ? '' : 'shadow-sm shadow-spirit-lightBorder',

    // Links and interactive elements
    link: isDarkMode ? 'text-spirit-accent hover:text-spirit-accent/80' : 'text-spirit-darkText hover:text-spirit-accent',
    buttonPrimary: isDarkMode ? 'bg-spirit-accent text-spirit-darkBg hover:bg-spirit-accent/90' : 'bg-spirit-darkText text-white hover:bg-spirit-darkText/90',
    buttonSecondary: isDarkMode ? 'bg-spirit-muted/30 text-white hover:bg-spirit-muted/40' : 'bg-spirit-lightMuted hover:bg-spirit-lightBorder',

    // Accents and highlights
    accent: isDarkMode ? 'text-spirit-accent' : 'text-spirit-darkText',
    accentBg: isDarkMode ? 'bg-spirit-accent' : 'bg-spirit-lightBorder',
    highlight: isDarkMode ? 'bg-spirit-accent/10' : 'bg-spirit-lightMuted',
  };

  // Update card styles to include shadows
  const cardStyle = `${themeClasses.cardBg} rounded-xl p-6 ${themeClasses.cardShadow} backdrop-blur-sm`;

  const handleTopicSelect = (topic) => {
    setSelectedTopic(topic);
    setIsLoading(true);
    
    // Set a brief loading state before showing the content
    setTimeout(() => {
      setIsLoading(false);
      setSelectedQuickTopic(topic); // This triggers the internal view
    }, 800);
  };

  const handleRandomTopic = () => {
    const randomTopic = quickTopics[Math.floor(Math.random() * quickTopics.length)];
    handleTopicSelect(randomTopic);
  };

  const parsePairs = (text) => {
    const pairs = [];
    const lines = text.split('\n');
    let currentPair = {};
    
    for (const line of lines) {
      if (line.toLowerCase().startsWith('invitation:') || line.toLowerCase().startsWith('explore:')) {
        currentPair.invitation = line.split(':')[1].trim();
      } else if (line.toLowerCase().startsWith('question:')) {
        currentPair.question = line.split(':')[1].trim();
        if (currentPair.invitation && currentPair.question) {
          pairs.push({...currentPair});
          currentPair = {};
        }
      }
    }
    return pairs;
  };

  const generateExplorationPairs = async (topic) => {
    try {
      const prompt = `Generate 3-5 exploration pairs about ${topic}. Each pair should have an invitation and a question in this format:

Invitation: [An inviting statement that encourages exploration of a specific aspect]
Question: [A thought-provoking question related to the invitation]

Example:
Invitation: Discover how offshore wind farms protect marine ecosystems
Question: What innovative methods do modern wind farms use to create artificial reefs around their foundations?

Make the pairs specifically about offshore wind farms and their technology, environmental impact, or operations.`;

      const response = await fetch('/api/gpt4o', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt })
      });

      if (!response.ok) throw new Error('Failed to generate pairs');

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let accumulatedText = '';

      while (true) {
        const { value, done } = await reader.read();
        if (done) break;
        
        const chunk = decoder.decode(value);
        const lines = chunk.split('\n');
        
        for (const line of lines) {
          if (line.startsWith('data: ')) {
            const data = line.slice(5);
            if (data === '[DONE]') continue;
            
            try {
              const parsed = JSON.parse(data);
              const content = parsed.choices?.[0]?.delta?.content || '';
              accumulatedText += content;
              const pairs = parsePairs(accumulatedText);
              setExplorationPairs(pairs);
            } catch (err) {
              if (err instanceof Error && err.message !== 'Unexpected end of JSON input') {
                console.error('Error processing pairs chunk:', err);
              }
            }
          }
        }
      }
    } catch (error) {
      console.error('Error generating pairs:', error);
    }
  };

  const generateContent = async (pair) => {
    console.log('Generating content for pair:', pair);
    
    // Kill any existing stream
    if (eventSourceRef.current) {
      eventSourceRef.current.close();
      if (fullResponse) {
        setDisplayedResponse(fullResponse);
      }
    }

    setIsLoading(true);
    setFullResponse('');
    setDisplayedResponse('');
    setError(null);

    try {
      const prompt = `${pair.invitation} Context: ${pair.question}

      Important industry information: This content must be specifically about OFFSHORE wind farms. Do not include any information about onshore wind farms or unrelated topics. All content must be strictly focused on offshore wind energy.

      Please provide a detailed response with clear structure using markdown formatting:
      - Use # for main headings
      - Use ## for subheadings
      - Use bullet points or numbered lists where appropriate
      - Include relevant examples and explanations
      - Break down complex concepts into digestible sections`;

      console.log('📡 Connecting to EventSource...');
      const params = new URLSearchParams({ prompt });
      const eventSource = new EventSource(`/api/ai?${params}`);
      eventSourceRef.current = eventSource;

      let chunkCount = 0;
      let totalCharacters = 0;
      let startTime = Date.now();
      let accumulatedContent = '';

      eventSource.onopen = () => {
        console.log('🔗 EventSource connection established');
      };

      eventSource.onmessage = (event) => {
        try {
          if (event.data === '[DONE]') {
            const duration = ((Date.now() - startTime) / 1000).toFixed(2);
            console.log(`✅ Stream complete:
- Total chunks received: ${chunkCount}
- Total characters: ${totalCharacters}
- Duration: ${duration}s
- Average speed: ${(totalCharacters / duration).toFixed(2)} chars/sec`);
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
            chunkCount++;
            totalCharacters += content.length;
            console.log(`📝 Chunk #${chunkCount} received: ${content.length} chars`);
            accumulatedContent += content;
            // Update both states immediately
            setFullResponse(accumulatedContent);
            setDisplayedResponse(accumulatedContent);
            setContent(accumulatedContent);
          }
        } catch (err) {
          if (err instanceof Error && err.message !== 'Unexpected end of JSON input') {
            console.error('❌ Error processing chunk:', err);
            setError({ message: err.message });
          }
        }
      };

      eventSource.onerror = (error) => {
        console.error('❌ EventSource error:', error);
        eventSource.close();
        setIsLoading(false);
        setError({ message: 'Connection error occurred' });
      };

    } catch (error) {
      console.error('Failed to generate content:', error);
      setError({ message: error.message });
      setIsLoading(false);
    }
  };

  const handleSuggestedDiscussion = async (question) => {
    const startTime = Date.now();
    console.log(`
🎯 [Client] Starting new discussion
📝 Question: "${question}"
⏱️  Time: ${new Date().toISOString()}
`);
    
    setCurrentQuestion(question);
    setSearchHistory(prev => [...prev, { content: question, type: 'question' }]);
    
    setSelectedQuickTopic({
      id: 'ai-response',
      title: question,
      content: ''
    });
    
    setIsLoading(true);
    setIsGeneratingPairs(true);
    setFullResponse('');
    setDisplayedResponse('');
    setError(null);

    try {
      const enhancedPrompt = `${question}

Please provide a detailed response with clear structure using markdown formatting:
- Use # for main headings
- Use ## for subheadings
- Use bullet points or numbered lists where appropriate
- Include relevant examples and explanations
- Break down complex concepts into digestible sections

Focus exclusively on offshore wind farms and structure the response with clear sections.`;

      console.log(`
📤 [Client] Sending request
📊 Stats:
- Prompt length: ${enhancedPrompt.length} chars
- Est. tokens: ${Math.round(enhancedPrompt.length / 4)}
`);

      const response = await fetch('/api/gpt4o', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ prompt: enhancedPrompt })
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      console.log('✅ [Client] Connected to stream');

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let chunkCount = 0;
      let totalChars = 0;
      let accumulatedContent = '';
      let lastProgressLog = Date.now();

      while (true) {
        const { value, done } = await reader.read();
        if (done) {
          const duration = ((Date.now() - startTime) / 1000).toFixed(2);
          console.log(`
🏁 [Client] Stream complete
📊 Final Stats:
- Duration: ${duration}s
- Total chunks: ${chunkCount}
- Total chars: ${totalChars}
- Chars/sec: ${Math.round(totalChars / parseFloat(duration))}
`);
          setIsLoading(false);
          setIsGeneratingPairs(false);
          generateExplorationPairs(question);
          break;
        }

        const chunk = decoder.decode(value);
        const lines = chunk.split('\n');
        
        for (const line of lines) {
          if (line.startsWith('data: ')) {
            const data = line.slice(5);
            if (data === '[DONE]') continue;

            try {
              const parsed = JSON.parse(data);
              const content = parsed.choices?.[0]?.delta?.content || '';
              if (content) {
                chunkCount++;
                totalChars += content.length;
                accumulatedContent += content;
                
                // Log progress every second
                const now = Date.now();
                if (now - lastProgressLog >= 1000) {
                  console.log(`
📊 [Client] Stream progress
- Chunks: ${chunkCount}
- Characters: ${totalChars}
- Current length: ${accumulatedContent.length}
`);
                  lastProgressLog = now;
                }

                // Update states immediately for each chunk
                flushSync(() => {
                  setFullResponse(accumulatedContent);
                  setDisplayedResponse(accumulatedContent);
                  setSelectedQuickTopic(current => ({
                    ...current,
                    content: accumulatedContent
                  }));
                });
              }
            } catch (err) {
              if (err instanceof Error && err.message !== 'Unexpected end of JSON input') {
                console.error('❌ [Client] Error processing chunk:', err);
              }
            }
          }
        }
      }
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'An unexpected error occurred';
      console.error(`❌ [Client] Stream error: ${errorMessage}`);
      setError({ message: errorMessage });
      setIsLoading(false);
      setIsGeneratingPairs(false);
    }
  };

  // Add handleFollowUpQuestion function back
  const handleFollowUpQuestion = async (question) => {
    const startTime = Date.now();
    console.log(`
🎯 [Client] Starting follow-up discussion
📝 Question: "${question}"
💭 Previous: "${currentQuestion}"
⏱️  Time: ${new Date().toISOString()}
`);
    
    setCurrentQuestion(question);
    setSearchHistory(prev => [...prev, { content: question, type: 'follow-up' }]);
    
    setIsLoading(true);
    setIsGeneratingPairs(true);
    setFullResponse('');
    setDisplayedResponse('');
    setError(null);

    try {
      // Create a context-aware prompt
      const enhancedPrompt = `Previous question: ${currentQuestion}
Previous response: ${fullResponse}

Follow-up question: ${question}

Please provide a detailed response that builds upon the previous context. Use markdown formatting:
- Use # for main headings
- Use ## for subheadings
- Use bullet points or numbered lists where appropriate
- Include relevant examples and explanations
- Break down complex concepts into digestible sections

Focus exclusively on offshore wind farms and ensure the response connects to the previous context when relevant.`;

      console.log(`
📤 [Client] Sending follow-up request
📊 Stats:
- Prompt length: ${enhancedPrompt.length} chars
- Est. tokens: ${Math.round(enhancedPrompt.length / 4)}
`);

      const response = await fetch('/api/gpt4o', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ prompt: enhancedPrompt })
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      console.log('✅ [Client] Connected to stream');

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let chunkCount = 0;
      let totalChars = 0;
      let accumulatedContent = '';
      let lastProgressLog = Date.now();

      while (true) {
        const { value, done } = await reader.read();
        if (done) {
          const duration = ((Date.now() - startTime) / 1000).toFixed(2);
          console.log(`
🏁 [Client] Follow-up stream complete
📊 Final Stats:
- Duration: ${duration}s
- Total chunks: ${chunkCount}
- Total chars: ${totalChars}
- Chars/sec: ${Math.round(totalChars / parseFloat(duration))}
`);
          setIsLoading(false);
          setIsGeneratingPairs(false);
          generateExplorationPairs(question);
          break;
        }

        const chunk = decoder.decode(value);
        const lines = chunk.split('\n');
        
        for (const line of lines) {
          if (line.startsWith('data: ')) {
            const data = line.slice(5);
            if (data === '[DONE]') continue;

            try {
              const parsed = JSON.parse(data);
              const content = parsed.choices?.[0]?.delta?.content || '';
              if (content) {
                chunkCount++;
                totalChars += content.length;
                accumulatedContent += content;
                
                // Log progress every second
                const now = Date.now();
                if (now - lastProgressLog >= 1000) {
                  console.log(`
📊 [Client] Follow-up stream progress
- Chunks: ${chunkCount}
- Characters: ${totalChars}
- Current length: ${accumulatedContent.length}
`);
                  lastProgressLog = now;
                }

                // Update states immediately for each chunk
                flushSync(() => {
                  setFullResponse(accumulatedContent);
                  setDisplayedResponse(accumulatedContent);
                  setSelectedQuickTopic(current => ({
                    ...current,
                    title: question,
                    content: accumulatedContent
                  }));
                });
              }
            } catch (err) {
              if (err instanceof Error && err.message !== 'Unexpected end of JSON input') {
                console.error('❌ [Client] Error processing follow-up chunk:', err);
              }
            }
          }
        }
      }
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'An unexpected error occurred';
      console.error(`❌ [Client] Follow-up stream error: ${errorMessage}`);
      setError({ message: errorMessage });
      setIsLoading(false);
      setIsGeneratingPairs(false);
    }
  };

  // Update the FollowUpSection component to handle real questions
  const FollowUpSection = () => {
    const [followUpQuestion, setFollowUpQuestion] = useState('');
    const inputRef = useRef(null);

    const handleSubmit = async (e) => {
      e.preventDefault();
      if (!followUpQuestion.trim() || isLoading) return;

      console.log('🔄 [Client] Submitting follow-up question:', followUpQuestion);
      
      // Call the handleFollowUpQuestion function with the current question
      await handleFollowUpQuestion(followUpQuestion);
      
      // Clear the input after submission
      setFollowUpQuestion('');
      
      // Focus back on the input for the next question
      inputRef.current?.focus();
    };

    const handleKeyDown = (e) => {
      if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        handleSubmit(e);
      }
    };

    return (
      <div className={`fixed bottom-0 left-0 right-0 z-40 ${themeClasses.mainBg} border-t ${themeClasses.border} shadow-lg`}>
        <div className="max-w-3xl mx-auto p-4">
          <form onSubmit={handleSubmit} className="flex items-center space-x-3">
            <div className="flex-1 relative">
              <div className="absolute left-4 top-1/2 transform -translate-y-1/2">
                <MessageSquare size={18} className={themeClasses.textSecondary} />
              </div>
              <input
                ref={inputRef}
                type="text"
                value={followUpQuestion}
                onChange={(e) => setFollowUpQuestion(e.target.value)}
                onKeyDown={handleKeyDown}
                placeholder="Ask a follow-up question..."
                disabled={isLoading}
                className={`w-full pl-12 pr-32 py-3 ${themeClasses.inputBg} border ${themeClasses.border} rounded-xl ${themeClasses.textPrimary} placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 ${isLoading ? 'opacity-50 cursor-not-allowed' : ''}`}
              />
              <div className="absolute right-3 top-1/2 transform -translate-y-1/2 flex items-center space-x-2">
                <ProToggle />
                <button 
                  type="submit"
                  disabled={!followUpQuestion.trim() || isLoading}
                  className={`p-1.5 ${themeClasses.hoverBg} rounded-lg transition-colors duration-200 ${!followUpQuestion.trim() || isLoading ? 'opacity-50 cursor-not-allowed' : ''}`}
                >
                  <ArrowRight size={16} className={themeClasses.textSecondary} />
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    );
  };

  // Move LeftSidebar component here, before the main return
  const LeftSidebar = () => (
    <div className={`hidden lg:block w-80 border-r ${themeClasses.border} ${themeClasses.sidebarBg} overflow-y-auto transition-colors duration-200`}>
      <div className="p-6">
        {/* Library Section */}
        <div className="mb-8">
          <h3 className={`text-lg font-semibold ${themeClasses.textPrimary} mb-4`}>Library</h3>
          <div className="space-y-2">
            {libraryConversations.map((conversation) => (
              <button
                key={conversation.id}
                onClick={() => handleSuggestedDiscussion(conversation.title)}
                className={`w-full text-left p-3 ${themeClasses.chipBg} rounded-lg ${themeClasses.hoverBg} transition-all duration-200 group`}
              >
                <div className="flex items-start space-x-3">
                  <div className="flex-shrink-0 mt-1">
                    {conversation.icon}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className={`text-sm font-medium ${themeClasses.textPrimary} truncate group-hover:text-blue-500 transition-colors duration-200`}>
                      {conversation.title}
                    </p>
                    <p className={`text-xs ${themeClasses.textSecondary} mt-0.5 truncate`}>
                      {conversation.preview}
                    </p>
                    <p className={`text-xs ${themeClasses.textTertiary} mt-1`}>
                      {conversation.timestamp}
                    </p>
                  </div>
                </div>
              </button>
            ))}
          </div>
        </div>

        {/* Topics Section */}
        <div>
          <h3 className={`text-lg font-semibold ${themeClasses.textPrimary} mb-4`}>Topics</h3>
          <div className="space-y-3">
            {quickTopics.map((topic) => (
              <div
                key={topic.id}
                className={`rounded-lg overflow-hidden ${
                  selectedTopic?.id === topic.id ? 'ring-2 ring-blue-500' : ''
                }`}
              >
                <button
                  onClick={() => handleTopicSelect(topic)}
                  className={`w-full text-left p-4 ${themeClasses.hoverBg} transition-all duration-200 group`}
                >
                  <h4 className={`text-lg font-medium ${themeClasses.textPrimary} mb-2 group-hover:text-blue-500 transition-colors duration-200`}>
                    {topic.title}
                  </h4>
                  <p className={`text-sm ${themeClasses.textSecondary} mb-3`}>
                    {topic.preview}
                  </p>
                  <div className="flex flex-wrap gap-2">
                    {topic.relatedTopics.map((related, index) => (
                      <span
                        key={index}
                        className={`text-xs px-2 py-1 ${themeClasses.chipBg} ${themeClasses.textTertiary} rounded-full`}
                      >
                        {related}
                      </span>
                    ))}
                  </div>
                </button>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );

  // Add LandingSection component here
  const LandingSection = () => (
    <div className="flex flex-col items-center justify-center min-h-[80vh] px-4">
      <div className="w-full max-w-3xl">
        <h1 className={`text-4xl font-bold ${themeClasses.textPrimary} mb-8 tracking-tight text-center`}>
          {selectedTopic ? `What do you want to know about ${selectedTopic.title}?` : 'What do you want to know?'}
        </h1>
        <div className="relative mb-8">
          <div className="absolute left-4 top-1/2 transform -translate-y-1/2">
            <MessageSquare size={20} className={themeClasses.textSecondary} />
          </div>
          <input
            type="text"
            value={currentQuestion}
            onChange={(e) => setCurrentQuestion(e.target.value)}
            placeholder={selectedTopic ? `Ask anything about ${selectedTopic.title.toLowerCase()}...` : "Ask anything about wind energy..."}
            className={`w-full pl-12 pr-32 py-4 ${themeClasses.inputBg} border ${themeClasses.border} rounded-2xl ${themeClasses.textPrimary} placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 text-lg backdrop-blur-sm ${themeClasses.cardShadow}`}
          />
          <div className="absolute right-3 top-1/2 transform -translate-y-1/2 flex items-center space-x-2">
            <ProToggle />
            <button 
              onClick={() => currentQuestion && handleSuggestedDiscussion(currentQuestion)}
              className={`p-2 ${themeClasses.hoverBg} rounded-lg transition-colors duration-200`}
            >
              <ArrowRight size={20} className={themeClasses.textSecondary} />
            </button>
          </div>
        </div>

        {selectedTopic && (
          <div className="mb-8 flex items-center justify-center">
            <button
              onClick={() => {
                setSelectedTopic(null);
                setCurrentQuestion('');
              }}
              className={`flex items-center space-x-2 px-3 py-1.5 ${themeClasses.chipBg} rounded-lg ${themeClasses.hoverBg} transition-colors duration-200 ${themeClasses.cardShadow}`}
            >
              <X size={16} className="text-blue-500" />
              <span className={themeClasses.textSecondary}>Clear Topic</span>
            </button>
          </div>
        )}

        <div className="mt-16">
          <h2 className={`text-lg font-semibold ${themeClasses.textPrimary} mb-4 text-center`}>
            Suggested Discussions
          </h2>
          <div className="space-y-3">
            <button 
              onClick={() => handleSuggestedDiscussion(
                "How do floating wind turbines maintain stability in rough seas?",
                "Discussion about advanced stabilization systems and mooring technologies"
              )}
              className={`w-full text-left ${cardStyle} group`}
            >
              <div className="flex items-start space-x-3">
                <MessageSquare size={18} className="text-blue-500 mt-1" />
                <div>
                  <p className={`${themeClasses.textPrimary} font-medium group-hover:text-blue-600 transition-colors duration-200`}>
                    How do floating wind turbines maintain stability in rough seas?
                  </p>
                  <p className={`text-sm ${themeClasses.textSecondary} mt-1`}>
                    Discussion about advanced stabilization systems and mooring technologies
                  </p>
                </div>
              </div>
            </button>

            <button 
              onClick={() => handleSuggestedDiscussion(
                "What's the latest in bird-safe wind turbine technology?",
                "Exploring new developments in wildlife protection measures"
              )}
              className={`w-full text-left ${cardStyle} group`}
            >
              <div className="flex items-start space-x-3">
                <MessageSquare size={18} className="text-blue-500 mt-1" />
                <div>
                  <p className={`${themeClasses.textPrimary} font-medium group-hover:text-blue-600 transition-colors duration-200`}>
                    What's the latest in bird-safe wind turbine technology?
                  </p>
                  <p className={`text-sm ${themeClasses.textSecondary} mt-1`}>
                    Exploring new developments in wildlife protection measures
                  </p>
                </div>
              </div>
            </button>

            <button 
              onClick={() => handleSuggestedDiscussion(
                "Can AI improve wind farm efficiency?",
                "Discussion on machine learning applications in wind energy"
              )}
              className={`w-full text-left ${cardStyle} group`}
            >
              <div className="flex items-start space-x-3">
                <MessageSquare size={18} className="text-blue-500 mt-1" />
                <div>
                  <p className={`${themeClasses.textPrimary} font-medium group-hover:text-blue-600 transition-colors duration-200`}>
                    Can AI improve wind farm efficiency?
                  </p>
                  <p className={`text-sm ${themeClasses.textSecondary} mt-1`}>
                    Discussion on machine learning applications in wind energy
                  </p>
                </div>
              </div>
            </button>
          </div>
        </div>
      </div>
    </div>
  );

  // Update the right sidebar rendering to show exploration pairs
  const RightSidebar = () => (
    <div className={`hidden xl:block w-80 border-l ${themeClasses.border} ${themeClasses.sidebarBg} overflow-y-auto transition-colors duration-200`}>
      <div className="p-6">
        <h3 className={`text-lg font-semibold mb-4 ${themeClasses.textPrimary}`}>Deep Dive</h3>
        <div className="space-y-3">
          {isGeneratingPairs ? (
            <div className="flex items-center space-x-2">
              <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
              <p className={`text-sm ${themeClasses.textSecondary}`}>
                Discovering related topics to explore...
              </p>
            </div>
          ) : explorationPairs.length > 0 ? (
            explorationPairs.map((pair, index) => (
              <button
                key={index}
                onClick={() => handleSuggestedDiscussion(pair.question)}
                className={`w-full text-left p-4 ${themeClasses.cardBg} rounded-lg hover:bg-blue-500/5 transition-all duration-200 group border ${themeClasses.border}`}
              >
                <p className={`text-sm font-medium ${themeClasses.textPrimary} mb-2`}>
                  {pair.invitation}
                </p>
                <p className={`text-sm ${themeClasses.textSecondary} group-hover:text-blue-500`}>
                  {pair.question}
                </p>
              </button>
            ))
          ) : (
            <p className={`text-sm ${themeClasses.textSecondary}`}>
              Ask a question to discover related topics
            </p>
          )}
        </div>
      </div>
    </div>
  );

  return (
    <div className={`min-h-screen ${themeClasses.mainBg} transition-colors duration-200`}>
      <div className="relative z-10 min-h-screen flex flex-col">
        {/* Header */}
        <header className={`${themeClasses.headerBg} border-b ${themeClasses.border} sticky top-0 z-50 transition-colors duration-200`}>
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex items-center justify-between h-16">
              <div className="flex-1 flex items-center justify-between">
                <div className="flex items-center space-x-4">
                  <button
                    onClick={() => setIsMenuOpen(!isMenuOpen)}
                    className={`p-2 rounded-lg ${themeClasses.hoverBg} transition-colors duration-200 lg:hidden`}
                  >
                    {isMenuOpen ? (
                      <X size={24} className={themeClasses.textPrimary} />
                    ) : (
                      <Menu size={24} className={themeClasses.textPrimary} />
                    )}
                  </button>
                </div>

                <div className="flex items-center space-x-2">
                  <Sparkles className={themeClasses.accent} size={24} />
                  <h1 className={`text-2xl font-bold ${themeClasses.accent} tracking-tight`}>
                    Spirit Wind Explorer
                  </h1>
                </div>

                <div className="flex items-center space-x-4">
                  {isAudioPlaying && (
                    <div className={`text-sm ${themeClasses.textSecondary} flex items-center gap-2`}>
                      <span className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                      <span>{audioSources[currentAudioIndex].name}</span>
                    </div>
                  )}
                  <button
                    onClick={toggleTheme}
                    className={`p-2 rounded-lg ${themeClasses.hoverBg} transition-colors duration-200`}
                  >
                    {isDarkMode ? (
                      <Sun size={20} className="text-yellow-400" />
                    ) : (
                      <Moon size={20} className="text-blue-600" />
                    )}
                  </button>
                </div>
              </div>
            </div>
          </div>
        </header>

        <div className="flex-1 flex">
          <LeftSidebar />
          {/* Main Content Area */}
          <main className="flex-1 min-w-0 flex flex-col">
            <div className="flex-1 flex flex-col h-[calc(100vh-4rem)]">
              <AnimatePresence mode="wait">
                {selectedQuickTopic ? (
                  <div className="flex-1 overflow-hidden p-4">
                    <div className="flex flex-col h-full">
                      {/* Compact Topic Navigation Bar */}
                      <div className={`flex items-center justify-between text-sm p-4 ${themeClasses.cardBg} rounded-xl ${themeClasses.cardShadow}`}>
                        <div className="flex items-center space-x-3">
                          <div className={`p-2 ${themeClasses.chipBg} rounded-lg`}>
                            <BookOpenIcon size={18} className="text-blue-500" />
                          </div>
                          <div>
                            <span className={`font-medium ${themeClasses.textPrimary}`}>{selectedQuickTopic.title}</span>
                            <p className={`text-xs ${themeClasses.textSecondary} mt-0.5`}>AI-powered response</p>
                          </div>
                        </div>
                        <button
                          onClick={() => setSelectedQuickTopic(null)}
                          className={`p-2 ${themeClasses.hoverBg} rounded-lg transition-colors duration-200`}
                        >
                          <X size={16} className={themeClasses.textSecondary} />
                        </button>
                      </div>

                      {/* Content Area with Real-time Streaming */}
                      <div className="flex-1 overflow-y-auto mt-4 pb-32">
                        <div className={`${cardStyle} h-full`}>
                          <div className="max-w-[680px] mx-auto">
                            {isLoading && !displayedResponse && (
                              <div className="flex items-center gap-3 p-4 bg-blue-500/10 rounded-lg animate-pulse mb-4">
                                <div className="flex items-center gap-2">
                                  <div className="w-2 h-2 bg-blue-500 rounded-full" />
                                  <p className={`text-sm ${themeClasses.textSecondary}`}>
                                    Generating response...
                                  </p>
                                </div>
                              </div>
                            )}
                            <div className={`${themeClasses.textPrimary} text-[17px] leading-[1.6]`}>
                              <article className="prose dark:prose-invert max-w-none">
                                <ReactMarkdown remarkPlugins={[remarkGfm]}>
                                  {displayedResponse || ''}
                                </ReactMarkdown>
                                {isLoading && (
                                  <div className="flex items-center gap-2 text-sm text-blue-500 mt-4">
                                    <span className="inline-block w-2 h-2 bg-blue-500 rounded-full animate-pulse" />
                                    <span>Generating more...</span>
                                  </div>
                                )}
                              </article>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                ) : (
                  <LandingSection />
                )}
              </AnimatePresence>
            </div>
          </main>

          <RightSidebar />
        </div>

        {/* Follow-up Section - Only show in content view */}
        {selectedQuickTopic && (
          <div className="fixed bottom-0 left-0 right-0 z-40">
            <FollowUpSection />
          </div>
        )}
      </div>
    </div>
  );
};

export default TopicExplorer;