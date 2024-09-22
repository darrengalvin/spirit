'use client';

import React, { useState, useEffect, useRef } from 'react';
import { ChevronRight, Video, BookOpen, FileDown, ArrowRight, ChevronUp, ChevronDown, Send, Menu, MessageCircle } from 'lucide-react';
import axios from 'axios';
import { motion, AnimatePresence } from 'framer-motion';

const topics = [
  {
    title: "Foundations",
    content: "Foundations are critical components in offshore wind farms, providing stability and support for wind turbines in challenging marine environments. They are designed to withstand extreme weather conditions, tidal forces, and the weight of the turbine structure.",
    subtopics: [
      {
        title: "Types of offshore wind foundations",
        description: "Learn about various foundation types used in offshore wind farms",
        content: `Offshore wind foundations come in several types, each suited to different water depths and seabed conditions:

        1. Monopile: The most common type for shallow waters (up to 30m), consisting of a large steel tube driven into the seabed.
        
        2. Gravity Base: Suitable for waters up to 60m deep, these are large concrete structures that rely on their weight for stability.
        
        3. Jacket: Used in deeper waters (30-80m), these are steel lattice structures fixed to the seabed with piles.
        
        4. Floating: For very deep waters (60m+), these foundations are anchored to the seabed and float on the surface.
        
        5. Suction Bucket: A newer technology where a steel bucket is lowered to the seabed and then pumped empty, creating a vacuum that pulls it into place.

        Each type has its advantages and is chosen based on factors like water depth, seabed geology, turbine size, and cost-effectiveness.`
      },
      {
        title: "Regular inspections and preventative maintenance",
        description: "Understand the importance of routine checks and maintenance",
        content: `Regular inspections and preventative maintenance are crucial for ensuring the longevity and safety of offshore wind foundations. Key aspects include:

        1. Inspection Schedule: Typically conducted annually or bi-annually, depending on the foundation type and environmental conditions.
        
        2. Visual Inspections: Using divers or ROVs to check for visible damage, corrosion, or marine growth.
        
        3. Structural Integrity Tests: Non-destructive testing methods to assess the internal condition of the foundation.
        
        4. Scour Monitoring: Regular checks for seabed erosion around the foundation base.
        
        5. Corrosion Protection: Inspection and maintenance of cathodic protection systems and protective coatings.
        
        6. Bolt Tensioning: Checking and re-tensioning of critical bolted connections.
        
        7. Grout Inspection: For certain foundation types, checking the condition of grout connections.

        Preventative maintenance aims to identify and address potential issues before they become critical, ensuring the continued safe operation of the wind turbine.`
      },
      {
        title: "Logistics for transporting offshore wind foundations",
        description: "Explore the complexities of moving massive foundation structures",
        content: `Transporting offshore wind foundations is a complex logistical operation involving:

        1. Specialized Vessels: Heavy-lift vessels or barges designed to carry large, heavy structures.
        
        2. Port Facilities: Deep-water ports with adequate storage space and heavy-lift capabilities.
        
        3. Weather Window Planning: Careful scheduling to ensure safe transport during favorable weather conditions.
        
        4. Route Planning: Determining the safest and most efficient route from manufacturing site to installation location.
        
        5. Load-out Operations: Carefully loading foundations onto transport vessels, often using self-propelled modular transporters (SPMTs).
        
        6. Sea Fastening: Securing foundations to the vessel to prevent movement during transit.
        
        7. Environmental Considerations: Minimizing environmental impact during transport and complying with regulations.
        
        8. Customs and Permits: Managing international shipping requirements and obtaining necessary permits.

        The logistics process requires meticulous planning and coordination to ensure safe and timely delivery of foundations to the offshore site.`
      },
      {
        title: "Above-the-water inspections for offshore wind foundations",
        description: "Discover techniques for inspecting the visible parts of foundations",
        content: `Above-water inspections of offshore wind foundations focus on the visible portions of the structure and typically include:

        1. Visual Inspections: Checking for visible damage, corrosion, or anomalies using high-resolution cameras and trained inspectors.
        
        2. Drone Surveys: Utilizing unmanned aerial vehicles (UAVs) to capture detailed imagery of hard-to-reach areas.
        
        3. Paint and Coating Checks: Assessing the condition of protective coatings to prevent corrosion.
        
        4. Structural Integrity Assessments: Examining welded joints, bolted connections, and overall structural alignment.
        
        5. J-tube and Cable Entry Inspections: Checking the condition of power cable entries and protective J-tubes.
        
        6. Transition Piece Examinations: Inspecting the connection between the foundation and the turbine tower.
        
        7. Platform and Access Point Checks: Ensuring the safety and integrity of access platforms and ladders.
        
        8. Marine Growth Assessment: Evaluating the extent of marine growth on the structure and its potential impact.

        These inspections are typically performed annually and play a crucial role in identifying potential issues early, ensuring the continued safe operation of the wind turbine.`
      },
      {
        title: "Subsea inspections for offshore wind foundations",
        description: "Dive into the methods used for underwater foundation checks",
        content: `Subsea inspections of offshore wind foundations are critical for assessing the underwater condition of the structure. These inspections typically involve:

        1. ROV Surveys: Using Remotely Operated Vehicles equipped with cameras and sensors to examine the submerged structure.
        
        2. Diver Inspections: In some cases, professional divers conduct close-up visual inspections and minor repairs.
        
        3. Sonar Scanning: Utilizing acoustic imaging to create detailed 3D models of the foundation and surrounding seabed.
        
        4. Scour Monitoring: Assessing seabed erosion around the foundation base, which can affect stability.
        
        5. Cathodic Protection Checks: Evaluating the effectiveness of corrosion prevention systems.
        
        6. Marine Growth Assessment: Measuring the thickness and extent of marine growth on the structure.
        
        7. Structural Integrity Tests: Conducting non-destructive testing on critical underwater components.
        
        8. Cable Connection Inspections: Examining the condition of power cable connections at the foundation.
        
        9. Seabed Topology Surveys: Mapping the seabed around the foundation to detect any changes over time.

        These subsea inspections are typically conducted annually or bi-annually, depending on the foundation type and environmental conditions. They are essential for maintaining the structural integrity and longevity of offshore wind foundations.`
      }
    ],
    resources: {
      videos: ["Types of Offshore Wind Foundations", "Foundation Installation Process", "Subsea Inspection Techniques"],
      courses: ["Offshore Foundation Design", "Preventative Maintenance for Offshore Structures", "ROV Operation for Subsea Inspections"],
      downloads: ["Foundation Maintenance Guide.pdf", "Offshore Wind Foundation Types.pdf", "Logistics Planning for Foundation Transport.pdf"]
    }
  },
  // ... Additional topics (Export & Array Cables, Vessels, Workforce, Offshore Wind Maintenance, Offshore Wind Port) would be added here in a similar format
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
  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(scrollToBottom, [messages]);

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
    <motion.div
      className="fixed top-16 right-6 bg-white rounded-lg shadow-2xl overflow-hidden z-30"
      initial={{ width: '320px', height: '60px' }}
      animate={{ 
        width: isExpanded ? '400px' : '320px', 
        height: isExpanded ? '500px' : '60px' 
      }}
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
            <div ref={messagesEndRef} />
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
  );
};

const TopicExplorer = () => {
  const [currentTopic, setCurrentTopic] = useState(topics[0]);
  const [currentSubtopic, setCurrentSubtopic] = useState(null);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [explorationPairs, setExplorationPairs] = useState([]);
  const [content, setContent] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [loadingStage, setLoadingStage] = useState(0);
  const [isGeneratingPairs, setIsGeneratingPairs] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  useEffect(() => {
    generateExplorationPairs(currentTopic.title);
  }, [currentTopic]);

  const generateExplorationPairs = async (topic) => {
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
      setExplorationPairs(pairs);
    } catch (error) {
      console.error('Failed to generate exploration pairs:', error);
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
        const invitation = lines[i].replace(/^\d+\.\s*[a-z]\)\s*/, '').replace(/\*\*/g, '').trim();
        const question = lines[i + 1].replace(/^\d+\.\s*[a-z]\)\s*/, '').replace(/\*\*/g, '').trim();
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
    setContent(''); // Clear existing content

    const prompt = `${pair.invitation} Context: ${pair.question}

    Important industry information: This content must be specifically about OFFSHORE wind farms. Do not include any information about onshore wind farms or unrelated topics. All content must be strictly focused on offshore wind energy.

    Please provide a detailed response formatted in HTML. Use only <h2>, <p>, <ul>, and <li> tags for structure. Do not include any inline styles or classes. Keep the content concise and informative, focusing exclusively on offshore wind farms. Do not include any labels like 'a)' or 'b)' in the content.`;

    try {
      setLoadingStage(1); // Move to "Gathering information" stage
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
      setLoadingStage(2); // Move to "Compiling insights" stage
      setContent(data.message.replace(/\*\*/g, '')); // Remove asterisks from content
    } catch (error) {
      console.error('Failed to generate content:', error);
    } finally {
      setLoadingStage(3); // Move to "Finalizing content" stage
      setIsLoading(false);
    }
  };

  const handleTopicChange = (topic) => {
    setCurrentTopic(topic);
    setCurrentSubtopic(null);
    changeBackgroundImage();
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
              <div className="mt-4 prose prose-sm max-w-none">
                <div dangerouslySetInnerHTML={{ __html: content }} />
              </div>
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
          <h2 className="text-xl font-semibold mb-4 text-[#1c2636]">{currentTopic.title}</h2>
          <p className="text-[#1c2636] text-base leading-relaxed mb-4">{currentTopic.content}</p>
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
      {/* Fixed Header */}
      <header className="bg-[#1c2636] text-white p-2 shadow-md z-20 flex justify-between items-center">
        <h1 className="text-xl lg:text-2xl font-bold">Offshore Wind Farm Explorer</h1>
        <button 
          className="md:hidden"
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
        >
          <Menu size={24} />
        </button>
      </header>

      {/* ChatBox */}
      <ChatBox />

      {/* Content Area */}
      <div className="flex flex-col md:flex-row flex-grow overflow-hidden">
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
                  {topics.map((topic, index) => (
                    <li key={index}>
                      <button
                        onClick={() => {
                          handleTopicChange(topic);
                          setIsMobileMenuOpen(false);
                        }}
                        className="w-full text-left p-2 rounded hover:bg-gray-100"
                      >
                        {topic.title}
                      </button>
                    </li>
                  ))}
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
            {renderContent()}
            
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
            {Object.entries(currentTopic.resources).map(([type, items]) => (
              <div key={type} className="mb-4">
                <h4 className="text-base lg:text-lg font-semibold mb-2 flex items-center text-[#1c2636]">
                  {type === 'videos' && <Video className="mr-2" size={18} />}
                  {type === 'courses' && <BookOpen className="mr-2" size={18} />}
                  {type === 'downloads' && <FileDown className="mr-2" size={18} />}
                  {type.charAt(0).toUpperCase() + type.slice(1)}
                </h4>
                <ul className="space-y-1">
                  {items.map((item, index) => (
                    <li key={index} className="text-blue-600 hover:underline cursor-pointer text-sm">{item}</li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>

        {/* Right Image Area - Hide on mobile */}
        <div className="hidden md:block w-1/3 relative">
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
          
          {/* Enhanced Next Topic Card */}
          <div className="absolute bottom-0 left-0 right-0 bg-green-100 p-4">
            <h3 className="text-lg font-semibold mb-2 text-green-800">Ready to Explore More?</h3>
            <p className="text-green-700 mb-4 text-sm">Dive into the next exciting topic in offshore wind farming.</p>
            <button
              onClick={() => handleTopicChange(topics[(topics.findIndex(t => t.title === currentTopic.title) + 1) % topics.length])}
              className="w-full bg-green-500 text-white py-2 px-4 rounded hover:bg-green-600 transition-colors duration-300 flex items-center justify-center text-sm"
            >
              <span className="mr-2">Explore Next Topic</span>
              <ArrowRight size={20} />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TopicExplorer;