'use client';

import React, { useState, useRef, useEffect } from 'react';
import { ChevronRight, Video, BookOpen, FileDown, Send } from 'lucide-react';

// ... (keep the existing topics and backgroundImages arrays)

const TopicExplorer = () => {
  // ... (keep existing state variables and useEffect)

  const renderContent = () => {
    if (currentSubtopic) {
      return (
        <div className="bg-white bg-opacity-90 p-6 rounded-lg shadow-lg">
          <h2 className="text-3xl font-semibold mb-4 text-gray-900">{currentSubtopic.title}</h2>
          <p className="text-gray-700 text-lg leading-relaxed mb-4">{currentSubtopic.description}</p>
          <div className="mt-4">
            <h3 className="text-xl font-semibold mb-2 text-gray-800">Content:</h3>
            <p className="text-gray-700">{currentSubtopic.content}</p>
          </div>
        </div>
      );
    } else {
      return (
        <div className="bg-white bg-opacity-90 p-6 rounded-lg shadow-lg">
          <h2 className="text-3xl font-semibold mb-4 text-gray-900">{currentTopic.title}</h2>
          <p className="text-gray-700 text-lg leading-relaxed">{currentTopic.content}</p>
        </div>
      );
    }
  };

  return (
    <div className="relative min-h-screen overflow-hidden">
      {/* Background Image */}
      <div 
        className={`absolute inset-0 bg-cover bg-center transition-opacity duration-1000 ${isTransitioning ? 'opacity-0' : 'opacity-100'}`}
        style={{ backgroundImage: `url(${backgroundImages[currentImageIndex]})` }}
      />
      <div className="absolute inset-0 bg-black bg-opacity-50 backdrop-filter backdrop-blur-sm" />

      {/* Content */}
      <div className="relative z-10 min-h-screen flex flex-col">
        <header className="bg-gray-800 bg-opacity-80 text-white p-4">
          <h1 className="text-3xl font-bold">Offshore Wind Farm Explorer</h1>
        </header>

        <div className="flex-grow flex p-8">
          {/* Main Content */}
          <div className="w-3/4 pr-8">
            {renderContent()}

            {/* Additional Resources Section */}
            <div className="mt-8 bg-white bg-opacity-90 p-6 rounded-lg shadow-lg">
              <h3 className="text-2xl font-semibold mb-4 text-gray-900">Additional Resources</h3>
              
              {/* Videos */}
              <div className="mb-6">
                <h4 className="text-xl font-semibold mb-2 flex items-center text-gray-800">
                  <Video className="mr-2" /> Videos to Watch
                </h4>
                <ul className="list-disc list-inside text-gray-700">
                  {currentTopic.resources.videos.map((video, index) => (
                    <li key={index} className="text-blue-600 hover:underline cursor-pointer">{video}</li>
                  ))}
                </ul>
              </div>
              
              {/* Courses */}
              <div className="mb-6">
                <h4 className="text-xl font-semibold mb-2 flex items-center text-gray-800">
                  <BookOpen className="mr-2" /> Course Content
                </h4>
                <ul className="list-disc list-inside text-gray-700">
                  {currentTopic.resources.courses.map((course, index) => (
                    <li key={index} className="text-blue-600 hover:underline cursor-pointer">{course}</li>
                  ))}
                </ul>
              </div>
              
              {/* Downloads */}
              <div>
                <h4 className="text-xl font-semibold mb-2 flex items-center text-gray-800">
                  <FileDown className="mr-2" /> Files to Download
                </h4>
                <ul className="list-disc list-inside text-gray-700">
                  {currentTopic.resources.downloads.map((file, index) => (
                    <li key={index} className="text-blue-600 hover:underline cursor-pointer">{file}</li>
                  ))}
                </ul>
              </div>
            </div>

            {/* Chat Interface */}
            <div className="bg-white bg-opacity-90 rounded-lg shadow-lg p-6 h-96 flex flex-col mt-8">
              <h3 className="text-2xl font-semibold mb-4 text-gray-900">Ask Questions</h3>
              <div className="flex-grow overflow-y-auto mb-4">
                {messages.map((msg, index) => (
                  <div key={index} className={`mb-2 ${msg.sender === 'user' ? 'text-right' : 'text-left'}`}>
                    <span className={`inline-block p-2 rounded-lg ${msg.sender === 'user' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-800'}`}>
                      {msg.text}
                    </span>
                  </div>
                ))}
                <div ref={chatEndRef} />
              </div>
              <div className="flex">
                <input
                  type="text"
                  value={input}
                  onChange={(e) => setInput(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && handleSend()}
                  placeholder="Type your question here..."
                  className="flex-grow border rounded-l-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
                <button
                  onClick={handleSend}
                  className="bg-blue-500 text-white p-2 rounded-r-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
                >
                  <Send size={24} />
                </button>
              </div>
            </div>
          </div>
          
          {/* Related Topics */}
          <div className="w-1/4">
            <h3 className="text-2xl font-semibold mb-4 text-white">Related Topics</h3>
            <ul className="space-y-4">
              {topics.map((topic, index) => (
                <li key={index}>
                  <button
                    onClick={() => handleTopicChange(topic)}
                    className="flex flex-col w-full text-left bg-white bg-opacity-90 hover:bg-opacity-100 transition-colors duration-300 p-4 rounded shadow"
                  >
                    <span className="font-semibold mb-2 text-gray-800">{topic.title}</span>
                    <ChevronRight size={20} className="self-end mt-2 text-gray-600" />
                  </button>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TopicExplorer;