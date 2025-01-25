'use client';

import React, { useState, useEffect } from 'react';
import { ChevronRight, Video, BookOpen, FileDown, Search, Menu, X, MessageSquare, Lightbulb, ArrowRight, Sparkles, BookOpenIcon, ArrowUpRight, Link, ExternalLink, Clock, Sun, Moon } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';

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

  useEffect(() => {
    // Check system preference on mount
    if (typeof window !== 'undefined') {
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      setIsDarkMode(prefersDark);
    }
  }, []);

  const toggleTheme = () => {
    setIsDarkMode(!isDarkMode);
  };

  // Theme classes
  const themeClasses = {
    // Base backgrounds
    mainBg: isDarkMode ? 'bg-[#1A1C1E]' : 'bg-[#E8E9EC]',
    headerBg: isDarkMode ? 'bg-[#2A2C2E]' : 'bg-[#EFF0F3]/80 backdrop-blur-sm',
    sidebarBg: isDarkMode ? 'bg-[#2A2C2E]' : 'bg-[#E2E4E8]',
    cardBg: isDarkMode ? 'bg-gray-800/50' : 'bg-[#EFF0F3]/90',
    inputBg: isDarkMode ? 'bg-gray-800' : 'bg-[#E2E4E8]',
    
    // Borders
    border: isDarkMode ? 'border-gray-800' : 'border-[#D8DCE3]',
    
    // Text colors
    textPrimary: isDarkMode ? 'text-white' : 'text-[#2C3542]',
    textSecondary: isDarkMode ? 'text-gray-400' : 'text-[#5A6478]',
    textTertiary: isDarkMode ? 'text-gray-300' : 'text-[#4A5468]',
    
    // Hover states
    hoverBg: isDarkMode ? 'hover:bg-gray-700' : 'hover:bg-[#DFE1E7]',
    
    // Special elements
    chipBg: isDarkMode ? 'bg-gray-800' : 'bg-[#E2E4E8]',
    gradientFrom: isDarkMode ? 'from-[#1A1C1E]' : 'from-[#E8E9EC]',
    gradientVia: isDarkMode ? 'via-[#1A1C1E]' : 'via-[#E8E9EC]',

    // Shadows for light mode
    cardShadow: isDarkMode ? '' : 'shadow-sm shadow-[#D8DCE3]',
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

  const handleAIResponse = async (question, context = '') => {
    const requestId = Math.random().toString(36).substring(7);
    console.log(`[${requestId}] 🎯 Starting AI response for question: "${question}"`);

    setIsLoading(true);
    setIsTyping(true);

    // Set initial state
    setSelectedQuickTopic({
      id: 'ai-response',
      title: question,
      content: ''
    });

    try {
      const response = await fetch('/api/ai', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          messages: [
            {
              role: 'user',
              content: `${context ? `Context: ${context}\n\n` : ''}${question}`
            }
          ]
        }),
      });

      if (!response.ok) {
        throw new Error(`API request failed with status ${response.status}`);
      }

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let text = '';

      while (true) {
        const { value, done } = await reader.read();
        if (done) break;

        const chunk = decoder.decode(value);
        text += chunk;

        // Update UI with each chunk
        setSelectedQuickTopic(prev => ({
          ...prev,
          content: text
        }));

        // Log progress
        console.log(`[${requestId}] Received chunk: ${chunk.length} characters`);
      }

      // Add to message history
      setMessages(prev => [...prev, 
        { role: 'user', content: question },
        { role: 'assistant', content: text }
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
                  <article className="prose dark:prose-invert max-w-none prose-headings:font-semibold prose-h2:text-2xl prose-h2:mt-8 prose-h2:mb-4 prose-p:my-4 prose-ul:my-4 prose-li:my-1 prose-strong:text-blue-500 dark:prose-strong:text-blue-400">
                    {selectedQuickTopic.content ? (
                      <ReactMarkdown 
                        remarkPlugins={[remarkGfm]}
                        components={{
                          h2: ({node, ...props}) => <h2 className="text-2xl font-semibold mt-8 mb-4" {...props} />,
                          p: ({node, ...props}) => <p className="my-4" {...props} />,
                          ul: ({node, ...props}) => <ul className="my-4 list-disc pl-6" {...props} />,
                          ol: ({node, ...props}) => <ol className="my-4 list-decimal pl-6" {...props} />,
                          li: ({node, ...props}) => <li className="my-1" {...props} />,
                          strong: ({node, ...props}) => <strong className="text-blue-500 dark:text-blue-400 font-semibold" {...props} />,
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
                  <Sparkles className="text-blue-500" size={24} />
                  <h1 className={`text-2xl font-bold ${themeClasses.textPrimary} tracking-tight`}>
                    Wind Energy Explorer
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
                    className="flex items-center justify-center py-20"
                  >
                    <div className="text-blue-400">Loading...</div>
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
                {selectedQuickTopic && contentDatabase[selectedQuickTopic.id]?.relatedQuestions.map((question, index) => (
                  <button
                    key={index}
                    onClick={() => handleSuggestedDiscussion(question)}
                    className={`w-full text-left p-3 ${themeClasses.chipBg} rounded-lg ${themeClasses.hoverBg} transition-all duration-200 group`}
                  >
                    <div className="flex items-start space-x-2">
                      <MessageSquare size={16} className="text-blue-500 mt-1 flex-shrink-0" />
                      <span className={`text-sm ${themeClasses.textTertiary} group-hover:text-blue-500 transition-colors duration-200`}>
                        {question}
                      </span>
                    </div>
                  </button>
                ))}
                {!selectedQuickTopic && (
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