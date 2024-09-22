'use client';

import React, { useState, useEffect } from 'react';
import { ChevronRight, Video, BookOpen, FileDown, ArrowRight, ChevronUp, ChevronDown, Send, Menu, MessageCircle } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import SpiritSideMenu from './spiritSideMenu';

const topicsList = [
  "Foundations",
  "Substation",
  "Wind Turbine Generator (WTG)",
  "Export & Array Cables",
  "Vessels",
  "Workforce",
  "Offshore Wind Maintenance",
  "Offshore Wind Port"
];

const backgroundImages = [
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968780/windfarms/Offshore_wind_port_dt3aef.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968780/windfarms/Offshore_wind_workforce_photo_jni2pm.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_Wind_Substation_ynraud.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_Wind_Vessel_photo_lufka3.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_wind_maintenance_photo_zgmlwl.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_wind_foundation_photo_sskion.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_Wind_Turbine_Generator_ztpavk.png"
];

const ChatBox = () => {
  const [isExpanded, setIsExpanded] = useState(false);
  const [messages, setMessages] = useState([
    { text: "Welcome! I'm your Offshore Wind Expert. How can I assist you today?", sender: 'ai' }
  ]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleSend = async () => {
    if (input.trim()) {
      const userMessage = { text: input, sender: 'user' };
      setMessages(prev => [...prev, userMessage]);
      setInput('');
      setIsLoading(true);

      try {
        const response = await fetch('/api/gpt4o', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            prompt: `You are an expert on offshore wind farms. Please provide a concise and informative answer to the following question: ${input}`
          }),
        });

        if (!response.ok) {
          throw new Error(response.statusText);
        }

        const data = await response.json();
        setMessages(prev => [...prev, { text: data.message, sender: 'ai' }]);
      } catch (error) {
        console.error('Failed to get AI response:', error);
        setMessages(prev => [
          ...prev, 
          { text: "I'm sorry, I couldn't process your request at the moment. Please try again later.", sender: 'ai' }
        ]);
      } finally {
        setIsLoading(false);
      }
    }
  };

  return (
    <div className="relative">
      <button
        onClick={() => setIsExpanded(!isExpanded)}
        className="bg-blue-600 text-white p-2 rounded-full hover:bg-blue-700 transition-colors duration-300"
      >
        <MessageCircle size={24} />
      </button>
      {isExpanded && (
        <motion.div
          className="absolute top-full right-0 mt-2 bg-white rounded-lg shadow-2xl overflow-hidden z-30"
          initial={{ width: '320px', height: '400px', opacity: 0 }}
          animate={{ width: '400px', height: '500px', opacity: 1 }}
          transition={{ duration: 0.3 }}
        >
          <div 
            className="bg-blue-600 p-4 flex justify-between items-center text-white cursor-pointer"
            onClick={() => setIsExpanded(!isExpanded)}
          >
            <div className="flex items-center">
              <MessageCircle size={24} className="mr-2" />
              <h3 className="font-semibold">Offshore Wind Expert</h3>
            </div>
            <button>
              {isExpanded ? <ChevronDown size={20} /> : <ChevronUp size={20} />}
            </button>
          </div>
          {isExpanded && (
            <div className="flex flex-col h-[440px]">
              <div className="flex-grow overflow-y-auto p-4 space-y-4">
                {messages.map((msg, index) => (
                  <div key={index} className={`flex ${msg.sender === 'user' ? 'justify-end' : 'justify-start'}`}>
                    <div className={`max-w-[70%] p-3 rounded-lg ${
                      msg.sender === 'user' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-800'
                    }`}>
                      {msg.text}
                    </div>
                  </div>
                ))}
                {isLoading && (
                  <div className="flex justify-start">
                    <div className="bg-gray-200 text-gray-800 p-3 rounded-lg">
                      <span className="animate-pulse">Thinking...</span>
                    </div>
                  </div>
                )}
              </div>
              <div className="p-4 bg-gray-100 border-t">
                <div className="flex items-center bg-white rounded-full shadow-inner">
                  <input
                    type="text"
                    value={input}
                    onChange={(e) => setInput(e.target.value)}
                    placeholder="Ask about offshore wind..."
                    className="flex-grow p-3 bg-transparent focus:outline-none rounded-l-full"
                    onKeyPress={(e) => e.key === 'Enter' && handleSend()}
                  />
                  <button 
                    onClick={handleSend}
                    className="p-3 text-blue-600 hover:text-blue-800 transition-colors duration-300 rounded-r-full"
                    disabled={isLoading}
                  >
                    <Send size={20} />
                  </button>
                </div>
              </div>
            </div>
          )}
        </motion.div>
      )}
    </div>
  );
};

const TopicExplorer = () => {
  const [currentTopic, setCurrentTopic] = useState(topicsList[0]);
  const [currentSubtopic, setCurrentSubtopic] = useState(null);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [explorationPairs, setExplorationPairs] = useState([]);
  const [content, setContent] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [loadingStage, setLoadingStage] = useState(0);
  const [isGeneratingPairs, setIsGeneratingPairs] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isSideMenuExpanded, setIsSideMenuExpanded] = useState(false);
  const [isChangingTopic, setIsChangingTopic] = useState(false);

  useEffect(() => {
    generateTopicContent(currentTopic);
  }, [currentTopic]);

  const generateTopicContent = async (topic) => {
    setIsLoading(true);
    setContent('');

    const prompt = `Provide a comprehensive summary of ${topic} in the context of offshore wind farms. 
    Important industry information: This content must be specifically about OFFSHORE wind farms. Do not include any information about onshore wind farms or unrelated topics. All content must be strictly focused on offshore wind energy.
    Format your response in HTML using only <h2>, <p>, <ul>, and <li> tags. Do not use any other HTML tags or attributes.`;

    try {
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
      generateExplorationPairs(topic);
    } catch (error) {
      console.error('Failed to generate topic content:', error);
    } finally {
      setIsLoading(false);
    }
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
    const lines = text.split('\n');
    for (let i = 0; i < lines.length; i += 2) {
      if (lines[i] && lines[i + 1]) {
        const invitation = lines[i].replace(/^\d+\.\s*[a-z]\)\s*/, '').replace(/^[a-z]\)\s*/, '').trim();
        const question = lines[i + 1].replace(/^\d+\.\s*[a-z]\)\s*/, '').replace(/^[a-z]\)\s*/, '').trim();
        if (invitation && question) {
          pairs.push({ invitation, question });
        }
      }
    }
    console.log('Parsed pairs:', pairs);
    return pairs;
  };

  const handleSubtopicClick = async (pair) => {
    console.log('Subtopic clicked:', pair);
    setCurrentSubtopic(pair);
    changeBackgroundImage();
    generateContent(pair);
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

  const handleTopicChange = (topic) => {
    setIsChangingTopic(true);
    setCurrentTopic(topic);
    setCurrentSubtopic(null);
    changeBackgroundImage();
    generateTopicContent(topic).finally(() => {
      setIsChangingTopic(false);
    });
  };

  const changeBackgroundImage = () => {
    setIsTransitioning(true);
    setTimeout(() => {
      setCurrentImageIndex((prevIndex) => (prevIndex + 1) % backgroundImages.length);
      setIsTransitioning(false);
    }, 500);
  };

  const renderContent = () => {
    if (currentSubtopic) {
      return (
        <AnimatePresence mode="wait">
          <motion.div
            key={currentSubtopic.invitation}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-xl font-semibold mb-4 text-[#1c2636]">{currentSubtopic.invitation}</h2>
            {isLoading ? (
              <LoadingEffect />
            ) : (
              <div className="mt-4 prose prose-sm max-w-none" dangerouslySetInnerHTML={{ __html: content }} />
            )}
          </motion.div>
        </AnimatePresence>
      );
    } else {
      return (
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h2 className="text-xl font-semibold mb-4 text-[#1c2636]">{currentTopic}</h2>
          <div className="mt-4 prose prose-sm max-w-none" dangerouslySetInnerHTML={{ __html: content }} />
        </motion.div>
      );
    }
  };

  const LoadingEffect = () => {
    const loadingMessages = [
      "Analyzing offshore wind data...",
      "Compiling expert insights...",
      "Exploring cutting-edge technologies...",
      "Investigating environmental impacts...",
      "Examining industry best practices...",
      "Synthesizing global research...",
      "Evaluating economic factors...",
      "Assessing maintenance strategies...",
      "This comprehensive analysis is worth the wait...",
      "Uncovering innovative solutions...",
      "Delving into complex engineering challenges...",
    ];

    const [messageIndex, setMessageIndex] = useState(0);

    useEffect(() => {
      const interval = setInterval(() => {
        setMessageIndex((prevIndex) => (prevIndex + 1) % loadingMessages.length);
      }, 3000);

      return () => clearInterval(interval);
    }, []);

    return (
      <div className="flex flex-col items-center justify-center h-64">
        <div className="relative w-24 h-24 mb-4">
          <div className="absolute top-0 left-0 w-full h-full border-4 border-blue-200 rounded-full animate-pulse"></div>
          <div className="absolute top-0 left-0 w-full h-full border-t-4 border-blue-500 rounded-full animate-spin"></div>
        </div>
        <div className="text-blue-500 font-bold mb-2 text-center">{loadingMessages[messageIndex]}</div>
        <motion.div
          className="w-64 h-2 bg-blue-200 rounded-full overflow-hidden"
          initial={{ width: 0 }}
          animate={{ width: "100%" }}
          transition={{ duration: 3, ease: "linear", repeat: Infinity }}
        >
          <motion.div 
            className="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-blue-500"
            initial={{ width: "0%" }}
            animate={{ width: "100%" }}
            transition={{ duration: 3, repeat: Infinity }}
          ></motion.div>
        </motion.div>
      </div>
    );
  };

  const DeepDiveLoader = () => {
    return (
      <div className="mt-4 lg:mt-6">
        <div className="flex items-center space-x-2 mb-4">
          <div className="w-4 h-4 bg-blue-500 rounded-full animate-pulse"></div>
          <span className="text-blue-500 font-semibold">Generating insights...</span>
        </div>
        <div className="relative pt-1">
          <div className="overflow-hidden h-2 mb-4 text-xs flex rounded bg-blue-200">
            <motion.div 
              className="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-blue-500"
              initial={{ width: "0%" }}
              animate={{ width: "100%" }}
              transition={{ duration: 3, repeat: Infinity }}
            ></motion.div>
          </div>
        </div>
        <div className="flex justify-between text-xs text-blue-700">
          <span>Analyzing topic</span>
          <span>Compiling data</span>
          <span>Finalizing</span>
        </div>
      </div>
    );
  };

  return (
    <div className="relative min-h-screen overflow-hidden bg-gray-100">
      {isChangingTopic && (
        <div className="absolute inset-0 bg-white bg-opacity-75 z-50 flex items-center justify-center">
          <div className="text-2xl font-bold text-blue-600">Loading new topic...</div>
        </div>
      )}
      
      {/* Fixed Header */}
      <header className="bg-[#1c2636] text-white p-2 shadow-md z-20 flex justify-between items-center">
        <div className="flex items-center">
          <button 
            className="md:hidden mr-2"
            onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          >
            <Menu size={24} />
          </button>
          <h1 className="text-xl lg:text-2xl font-bold md:ml-20">Offshore Wind Farm Explorer</h1>
        </div>
        <ChatBox />
      </header>

      {/* SideMenu */}
      <SpiritSideMenu onExpand={setIsSideMenuExpanded} />

      {/* Content Area */}
      <div className={`flex flex-col md:flex-row flex-grow overflow-hidden transition-all duration-300 ${isSideMenuExpanded ? 'md:ml-64' : 'md:ml-20'}`}>
        {/* Mobile Menu */}
        <AnimatePresence>
          {isMobileMenuOpen && (
            <motion.div
              initial={{ x: '-100%' }}
              animate={{ x: 0 }}
              exit={{ x: '-100%' }}
              transition={{ duration: 0.3 }}
              className="fixed inset-0 bg-gray-800 bg-opacity-75 z-30 md:hidden"
              onClick={() => setIsMobileMenuOpen(false)}
            >
              <div className="w-3/4 h-full bg-white p-4" onClick={(e) => e.stopPropagation()}>
                <h2 className="text-xl font-bold mb-4">Topics</h2>
                <ul className="space-y-2">
                  {/* ... (rest of the code remains unchanged) */}
                </ul>
              </div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Main Content */}
        <div className="w-full md:w-2/3 overflow-y-auto p-4 md:p-6">
          <motion.div
            className="bg-white p-4 md:p-6 rounded-lg shadow-lg mb-4 md:mb-6"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            {isChangingTopic || isLoading ? (
              <LoadingEffect />
            ) : (
              renderContent()
            )}
            
            {explorationPairs.length > 0 && (
              <motion.div
                className="mt-8 bg-blue-50 p-4 rounded-lg shadow"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.5, delay: 0.2 }}
              >
                <h3 className="text-lg font-semibold mb-2 text-blue-800">Looking for more insights?</h3>
                <p className="text-blue-600 mb-4">Explore these follow-up topics to deepen your understanding of offshore wind farms.</p>
              </motion.div>
            )}

            <div className="mt-4 lg:mt-6">
              {isGeneratingPairs ? (
                <div>
                  <h3 className="text-lg font-semibold mb-2 lg:mb-3 text-[#1c2636]">Preparing Deep Dive Topics</h3>
                  <DeepDiveLoader />
                </div>
              ) : explorationPairs.length > 0 ? (
                <>
                  <h3 className="text-lg font-semibold mb-2 lg:mb-3 text-[#1c2636]">Deep Dive</h3>
                  <ul className="space-y-2">
                    {explorationPairs.map((pair, index) => (
                      <motion.li
                        key={index}
                        initial={{ opacity: 0, x: -20 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ duration: 0.3, delay: index * 0.1 }}
                      >
                        <button
                          onClick={() => handleSubtopicClick(pair)}
                          className="w-full text-left bg-blue-50 hover:bg-blue-100 transition-colors duration-300 p-2 rounded shadow text-sm"
                        >
                          <span className="font-medium text-blue-800">
                            {pair.invitation}
                          </span>
                        </button>
                      </motion.li>
                    ))}
                  </ul>
                </>
              ) : null}
            </div>
          </motion.div>

          {/* Additional Resources */}
          <div className="bg-white p-4 md:p-6 rounded-lg shadow-lg mb-4 md:mb-6">
            <h3 className="text-lg lg:text-xl font-semibold mb-2 lg:mb-3 text-[#1c2636]">Additional Resources</h3>
            {/* ... (rest of the code remains unchanged) */}
          </div>
        </div>

        {/* Right Image Area - Hide on mobile */}
        <div className="hidden md:block w-1/3 relative">
          {/* Topics List */}
          <div className="absolute top-0 left-0 right-0 bg-green-100 p-4 z-10">
            <h3 className="text-lg font-semibold mb-2 text-green-800">Topics</h3>
            <ul className="list-disc list-inside mb-4 text-sm text-green-700">
              {topicsList.map((topic, index) => (
                <li key={index} className="mb-1">
                  <button
                    onClick={() => handleTopicChange(topic)}
                    className="text-left hover:underline focus:outline-none"
                  >
                    {topic}
                  </button>
                </li>
              ))}
            </ul>
            <button
              onClick={() => handleTopicChange(topicsList[(topicsList.indexOf(currentTopic) + 1) % topicsList.length])}
              className={`w-full ${isChangingTopic ? 'bg-gray-400' : 'bg-green-500 hover:bg-green-600'} text-white py-2 px-4 rounded transition-colors duration-300 flex items-center justify-center text-sm`}
              disabled={isChangingTopic}
            >
              <span className="mr-2">{isChangingTopic ? 'Changing Topic...' : 'Explore Next Topic'}</span>
              <ArrowRight size={20} />
            </button>
          </div>

          <div className="h-full relative">
            <div 
              className={`absolute inset-0 bg-cover bg-center transition-opacity duration-1000 ${isTransitioning ? 'opacity-0' : 'opacity-100'}`}
              style={{ 
                backgroundImage: `url(${backgroundImages[currentImageIndex]})`,
                backgroundSize: 'cover',
                backgroundPosition: 'center',
                imageRendering: 'crisp-edges'
              }}
            />
            <div className="absolute inset-0 bg-black bg-opacity-30" />
          </div>
        </div>
      </div>
    </div>
  );
};

export default TopicExplorer;