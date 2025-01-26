'use client';

import React, { useState, useEffect } from 'react';
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
  // Add audio ref
  const audioRef = React.useRef(new Audio('https://firebasestorage.googleapis.com/v0/b/yourcaio-649fe.firebasestorage.app/o/180050__kangaroovindaloo__esperance-wind-farm-up-close.wav?alt=media&token=1002efca-fc16-4a00-bb50-477b0a632cdf'));

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

  useEffect(() => {
    // Check system preference on mount
    if (typeof window !== 'undefined') {
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      setIsDarkMode(prefersDark);
    }
  }, []);

  // Add effect to handle audio after the existing useEffects
  useEffect(() => {
    if (isGeneratingPairs) {
      audioRef.current.loop = true;
      audioRef.current.volume = 0.3; // Set to 30% volume
      audioRef.current.play().catch(e => console.log('Audio play failed:', e));
    } else {
      audioRef.current.pause();
      audioRef.current.currentTime = 0;
    }

    // Cleanup
    return () => {
      audioRef.current.pause();
      audioRef.current.currentTime = 0;
    };
  }, [isGeneratingPairs]);

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

  const generateExplorationPairs = async (topic, retries = 3) => {
    setIsGeneratingPairs(true);
    console.log('Generating exploration pairs for topic:', topic);
    const prompt = `Analyze the following topic and generate a series of exploration pairs as described: ${topic}

    Important industry information: This topic is specifically about OFFSHORE wind farms. Do not include any information about onshore wind farms or unrelated topics. All questions and content must be strictly focused on offshore wind energy.

    "Analyze the given topic and generate a series of exploration pairs. Each pair should consist of:
    a) An invitation to explore deeper, using phrases like 'Understand', 'Explore', 'Discover', 'Learn about', or 'Dive into'. This should be followed by a key aspect of the topic related to offshore wind farms.
    b) A specific question that directly relates to the exploration invitation, focusing exclusively on offshore wind farms.
    Ensure that the pairs cover various aspects including components, processes, maintenance, logistics, and roles involved. The questions should be specific enough to guide a detailed response while remaining open-ended enough to encourage comprehensive exploration."`;

    try {
      console.log('Sending API request for exploration pairs');
      const response = await fetch('/api/gpt4o', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ prompt }),
      });

      if (!response.ok) {
        throw new Error(response.statusText);
      }

      const data = await response.json();
      console.log('API response for exploration pairs:', data.message);
      const pairs = parsePairs(data.message);
      if (pairs.length === 0 && retries > 0) {
        console.log('No pairs generated, retrying...');
        return generateExplorationPairs(topic, retries - 1);
      }
      setExplorationPairs(pairs);
    } catch (error) {
      console.error('Failed to generate exploration pairs:', error);
      if (retries > 0) {
        console.log('Retrying...');
        return generateExplorationPairs(topic, retries - 1);
      }
    } finally {
      setIsGeneratingPairs(false);
    }
  };

  const parsePairs = (text) => {
    console.log('Parsing pairs from text:', text);
    const pairs = [];
    const lines = text.split('\n').filter(line => line.trim() !== '');
    
    for (let i = 0; i < lines.length; i += 2) {
      if (lines[i] && lines[i + 1]) {
        const invitationMatch = lines[i].match(/^a\)\s*(.+)/);
        const questionMatch = lines[i + 1].match(/^b\)\s*(.+)/);
        
        if (invitationMatch && questionMatch) {
          const invitation = invitationMatch[1].trim();
          const question = questionMatch[1].trim();
          
          if (invitation && question) {
            pairs.push({ invitation, question });
          } else {
            console.warn('Invalid pair detected:', lines[i], lines[i + 1]);
          }
        } else {
          console.warn('Unexpected format:', lines[i], lines[i + 1]);
        }
      }
    }
    
    console.log('Parsed pairs:', pairs);
    return pairs;
  };

  const generateContent = async (pair) => {
    console.log('Generating content for pair:', pair);
    setIsLoading(true);
    setLoadingStage(0);
    setContent('');

    const topicQuestions = {
      "Foundations": [
        "What are the types of offshore wind foundations?",
        "What are the regular inspections and preventative maintenance?",
        "What is preventative maintenance for offshore foundations?",
        "What are the logistics for transporting offshore wind foundations?",
        "What are above-the-water inspections for offshore wind foundations?",
        "What are the subsea inspections for offshore wind foundations?"
      ],
      // ... add the questions for other topics here
    };

    const currentTopicQuestions = topicQuestions[currentTopic] || [];

    const prompt = `${pair.invitation} Context: ${pair.question}

    Important industry information: This content must be specifically about OFFSHORE wind farms. Do not include any information about onshore wind farms or unrelated topics. All content must be strictly focused on offshore wind energy.

    Please consider the following questions when generating your response:
    ${currentTopicQuestions.join('\n')}

    Please provide a detailed response formatted in HTML. Use only <h2>, <p>, <ul>, and <li> tags for structure. Do not include any inline styles or classes. Keep the content concise and informative, focusing exclusively on offshore wind farms. Do not include any labels like 'a)' or 'b)' in the content.`;

    try {
      setLoadingStage(1);
      console.log('Sending API request for content generation');
      const response = await fetch('/api/gpt4o', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ prompt }),
      });

      if (!response.ok) {
        throw new Error(response.statusText);
      }

      const data = await response.json();
      const formattedContent = data.message
        .replace(/\n\n/g, '</p><p>')
        .replace(/\n/g, '<br>')
        .replace(/\s*<\/p><p>\s*/g, '</p><p>')
        .replace(/{"message":"/, '')
        .replace(/"}$/, '');

      setContent(formattedContent);
    } catch (error) {
      console.error('Failed to generate content:', error);
    } finally {
      setLoadingStage(3);
      setIsLoading(false);
    }
  };

  // Modify handleAIResponse to run exploration pairs in parallel
  const handleAIResponse = async (question, context = '') => {
    const requestId = Math.random().toString(36).substring(7);
    console.log(`[${requestId}] 🎯 Starting AI response for question: "${question}"`);

    setIsLoading(true);
    setIsTyping(true);

    // Start generating exploration pairs in parallel
    const explorationPromise = generateExplorationPairs(question);

    try {
      // Create a new topic with empty content
      setSelectedQuickTopic({
        id: 'ai-response',
        title: question,
        content: ''
      });

      const params = new URLSearchParams({ 
        prompt: `${context ? `Context: ${context}\n\n` : ''}${question}`
      });
      
      const eventSource = new EventSource(`/api/ai?${params}`);
      let accumulatedText = '';

      eventSource.onmessage = (event) => {
        try {
          if (event.data === '[DONE]') {
            console.log(`[${requestId}] Stream complete`);
            eventSource.close();
            setIsTyping(false);
            return;
          }

          const data = JSON.parse(event.data);
          if (data.error) {
            throw new Error(data.error);
          }

          const content = data.choices?.[0]?.delta?.content || '';
          if (content) {
            accumulatedText += content;
            setSelectedQuickTopic(current => ({
              ...current,
              content: accumulatedText
            }));
          }
        } catch (err) {
          console.error(`[${requestId}] Parse error:`, err);
          if (err.message !== 'Unexpected end of JSON input') {
            throw err;
          }
        }
      };

      eventSource.onerror = (error) => {
        console.error(`[${requestId}] EventSource error:`, error);
        eventSource.close();
        setIsTyping(false);
        throw new Error('Connection error occurred');
      };

      await explorationPromise;

      // Add to message history
      setMessages(prev => [...prev, 
        { role: 'user', content: question },
        { role: 'assistant', content: accumulatedText }
      ]);

    } catch (error) {
      console.error(`[${requestId}] ❌ Error:`, error);
      setSelectedQuickTopic(prev => ({
        ...prev,
        content: `Error: ${error.message}. Please try again.`
      }));
    } finally {
      setIsLoading(false);
      setIsTyping(false);
    }
  };

  const handleSuggestedDiscussion = async (question, description = '') => {
    setCurrentQuestion(question);
    setSearchHistory(prev => [...prev, { content: question, type: 'question' }]);
    
    // Create a temporary topic for the UI
    const tempTopic = {
      id: 'ai-response',
      title: question,
      subtitle: description || 'AI-generated response',
      content: 'Loading...'
    };
    
    setSelectedQuickTopic(tempTopic);
    
    // Get AI response
    await handleAIResponse(question);
  };

  const handleFollowUpQuestion = async (question) => {
    // Include previous context in the follow-up
    const context = messages.map(m => `${m.role}: ${m.content}`).join('\n');
    await handleAIResponse(question, context);
  };

  // Pro tooltip content
  const ProTooltip = () => (
    <div className={`absolute bottom-full right-0 mb-2 w-72 ${isDarkMode ? 'bg-[#2A2C2E]' : 'bg-white'} rounded-xl p-4 shadow-lg border ${themeClasses.border} transition-all duration-200 z-50`}>
      <div className="flex items-center space-x-2 mb-2">
        <Sparkles className="text-blue-500" size={18} />
        <h4 className={`font-semibold ${themeClasses.textPrimary}`}>Pro Search</h4>
      </div>
      <p className={`text-sm ${themeClasses.textSecondary} mb-3`}>
        Uses AI model wind-9901 our latest model which will give you more in depth well crafted responses.
      </p>
      <div className={`text-xs ${themeClasses.textTertiary} mb-4`}>
        {proSearchesLeft} searches left today
      </div>
      <button 
        onClick={() => {/* Handle Pro upgrade */}}
        className="w-full py-2 px-4 bg-blue-500 hover:bg-blue-600 text-white rounded-lg transition-colors duration-200 text-sm font-medium"
      >
        Get more Pro Searches
      </button>
    </div>
  );

  // Pro toggle component
  const ProToggle = () => (
    <div className="relative">
      <button
        onMouseEnter={() => setShowProTooltip(true)}
        onMouseLeave={() => setShowProTooltip(false)}
        onClick={() => setIsPro(!isPro)}
        className="flex items-center space-x-2 px-3 py-1.5 rounded-full transition-all duration-200"
      >
        <div className={`w-8 h-4 rounded-full ${isPro ? 'bg-blue-500' : 'bg-gray-600'} relative transition-colors duration-200`}>
          <div className={`absolute top-0.5 left-0.5 w-3 h-3 rounded-full bg-white transform transition-transform duration-200 ${isPro ? 'translate-x-4' : ''}`} />
        </div>
        <span className={`text-sm ${themeClasses.textSecondary}`}>Pro</span>
      </button>
      {showProTooltip && <ProTooltip />}
    </div>
  );

  // Update the FollowUpSection component to handle real questions
  const FollowUpSection = () => {
    const [followUpQuestion, setFollowUpQuestion] = useState('');

    const handleSubmit = async (e) => {
      e.preventDefault();
      if (!followUpQuestion.trim()) return;

      await handleFollowUpQuestion(followUpQuestion);
      setFollowUpQuestion('');
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
                type="text"
                value={followUpQuestion}
                onChange={(e) => setFollowUpQuestion(e.target.value)}
                placeholder="Ask follow-up question..."
                className={`w-full pl-12 pr-32 py-3 ${themeClasses.inputBg} border ${themeClasses.border} rounded-xl ${themeClasses.textPrimary} placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200`}
              />
              <div className="absolute right-3 top-1/2 transform -translate-y-1/2 flex items-center space-x-2">
                <ProToggle />
                <button 
                  type="submit"
                  disabled={!followUpQuestion.trim() || isTyping}
                  className={`p-1.5 ${themeClasses.hoverBg} rounded-lg transition-colors duration-200 ${isTyping ? 'opacity-50 cursor-not-allowed' : ''}`}
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

  // Landing Question Section
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

  const renderContent = () => {
    if (!selectedQuickTopic) return null;

    return (
      <div className="flex flex-col h-full">
        {/* Compact Topic Navigation Bar */}
        <div className={`flex items-center justify-between text-sm mb-6 p-4 ${themeClasses.cardBg} rounded-xl ${themeClasses.cardShadow}`}>
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

        {/* Scrollable Content Area */}
        <div className="flex-1 overflow-y-auto mb-4 pr-4 -mr-4">
          <div className="space-y-8">
            {/* Main Content Card */}
            <div className={`${cardStyle} space-y-8`}>
              <div className="max-w-[680px] mx-auto">
                <div className={`${themeClasses.textPrimary} text-[17px] leading-[1.6] space-y-6`}>
                  <article className="prose dark:prose-invert max-w-none">
                    {selectedQuickTopic.content ? (
                      <ReactMarkdown 
                        remarkPlugins={[remarkGfm]}
                        components={{
                          h2: ({node, ...props}) => <h2 className={`text-2xl font-semibold mt-8 mb-4 ${themeClasses.textPrimary}`} {...props} />,
                          p: ({node, ...props}) => <p className="my-4" {...props} />,
                          ul: ({node, ...props}) => <ul className="my-4 list-disc pl-6" {...props} />,
                          ol: ({node, ...props}) => <ol className="my-4 list-decimal pl-6" {...props} />,
                          li: ({node, ...props}) => <li className="my-1" {...props} />,
                          strong: ({node, ...props}) => <strong className={`${themeClasses.accent} font-semibold`} {...props} />,
                        }}
                      >
                        {selectedQuickTopic.content}
                      </ReactMarkdown>
                    ) : (
                      <div className="flex items-center space-x-2">
                        <span>Generating response</span>
                        <span className="inline-block w-2 h-4 bg-blue-500 animate-pulse" />
                      </div>
                    )}
                    {isTyping && (
                      <span className="inline-block w-2 h-4 bg-blue-500 animate-pulse ml-1" />
                    )}
                  </article>
                </div>
              </div>
            </div>

            {/* Mobile Deep Dive Section - Only show when right sidebar is hidden */}
            <div className="xl:hidden">
              {explorationPairs.length > 0 && (
                <motion.div
                  className={`${cardStyle} mt-8`}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.5, delay: 0.2 }}
                >
                  <h3 className={`text-lg font-semibold ${themeClasses.textPrimary} mb-4`}>Deep Dive</h3>
                  <div className="space-y-3">
                    {isGeneratingPairs ? (
                      <div className={`p-4 ${themeClasses.cardBg} rounded-lg`}>
                        <div className="flex items-center space-x-3">
                          <div className="w-2 h-2 bg-blue-500 rounded-full animate-pulse" />
                          <p className={`text-sm ${themeClasses.textSecondary}`}>
                            Analyzing {selectedQuickTopic?.title || 'your question'} to find relevant deep dive topics...
                          </p>
                        </div>
                      </div>
                    ) : (
                      explorationPairs.map((pair, index) => (
                        <button
                          key={index}
                          onClick={() => handleSuggestedDiscussion(pair.question)}
                          className={`w-full text-left p-3 ${themeClasses.chipBg} rounded-lg ${themeClasses.hoverBg} transition-all duration-200 group`}
                        >
                          <div className="flex items-start space-x-2">
                            <MessageSquare size={16} className="text-blue-500 mt-1 flex-shrink-0" />
                            <div>
                              <p className={`text-sm font-medium ${themeClasses.textPrimary} group-hover:text-blue-500 transition-colors duration-200`}>
                                {pair.invitation}
                              </p>
                              <p className={`text-xs ${themeClasses.textSecondary} mt-1`}>
                                {pair.question}
                              </p>
                            </div>
                          </div>
                        </button>
                      ))
                    )}
                  </div>
                </motion.div>
              )}
            </div>
          </div>
        </div>
      </div>
    );
  };

  // Update the Topics section in LeftSidebar to remove "I'm Feeling Lucky"
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
        </header>

        <div className="flex-1 flex">
          <LeftSidebar />
          {/* Main Content Area */}
          <main className="flex-1 min-w-0 flex flex-col">
            <div className="flex-1 px-4 sm:px-6 lg:px-8 py-8 mb-[76px]">
              <AnimatePresence mode="wait">
                {isLoading ? (
                  <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="flex flex-col items-center justify-center py-20 space-y-6"
                  >
                    <div className={`${cardStyle} max-w-lg w-full`}>
                      <div className="flex flex-col space-y-4">
                        <div className="flex items-center space-x-3">
                          <div className="w-2 h-2 bg-blue-500 rounded-full animate-pulse" />
                          <p className={`${themeClasses.textPrimary}`}>
                            {selectedQuickTopic ? `Analyzing "${selectedQuickTopic.title}"...` : 'Preparing response...'}
                          </p>
                        </div>
                        {isGeneratingPairs && (
                          <div className="flex items-center space-x-3">
                            <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                            <p className={`${themeClasses.textSecondary}`}>
                              Generating deep dive topics about {selectedQuickTopic?.title || 'this topic'}...
                            </p>
                          </div>
                        )}
                      </div>
                    </div>
                  </motion.div>
                ) : selectedQuickTopic ? (
                  <div className="h-[calc(100vh-8rem-76px)]">
                    {renderContent()}
                  </div>
                ) : (
                  <LandingSection />
                )}
              </AnimatePresence>
            </div>
          </main>

          {/* Right Sidebar - Deep Dive */}
          <div className={`hidden xl:block w-80 border-l ${themeClasses.border} ${themeClasses.sidebarBg} overflow-y-auto transition-colors duration-200`}>
            <div className="p-6">
              <h3 className={`text-lg font-semibold mb-4 ${themeClasses.textPrimary}`}>Deep Dive</h3>
              <div className="space-y-3">
                {isGeneratingPairs ? (
                  <div className={`p-4 ${themeClasses.cardBg} rounded-lg`}>
                    <div className="flex items-center space-x-3">
                      <div className="w-2 h-2 bg-blue-500 rounded-full animate-pulse" />
                      <p className={`text-sm ${themeClasses.textSecondary}`}>
                        Analyzing {selectedQuickTopic?.title || 'your question'} to find relevant deep dive topics...
                      </p>
                    </div>
                  </div>
                ) : explorationPairs.length > 0 ? (
                  explorationPairs.map((pair, index) => (
                    <button
                      key={index}
                      onClick={() => handleSuggestedDiscussion(pair.question)}
                      className={`w-full text-left p-3 ${themeClasses.chipBg} rounded-lg ${themeClasses.hoverBg} transition-all duration-200 group`}
                    >
                      <div className="flex items-start space-x-2">
                        <MessageSquare size={16} className="text-blue-500 mt-1 flex-shrink-0" />
                        <div>
                          <p className={`text-sm font-medium ${themeClasses.textPrimary} group-hover:text-blue-500 transition-colors duration-200`}>
                            {pair.invitation}
                          </p>
                          <p className={`text-xs ${themeClasses.textSecondary} mt-1`}>
                            {pair.question}
                          </p>
                        </div>
                      </div>
                  </button>
                  ))
                ) : (
                  <div className={`p-4 ${themeClasses.cardBg} rounded-lg`}>
                    <p className={`text-sm ${themeClasses.textSecondary} text-center`}>
                      Select a topic or ask a question to explore deeper
                    </p>
                  </div>
                )}
              </div>
            </div>
          </div>
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