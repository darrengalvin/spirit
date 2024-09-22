'use client';

import React, { useState, useRef, useEffect } from 'react';
import { ChevronRight, Video, BookOpen, FileDown, Send } from 'lucide-react';

// ... (keep the existing topics and backgroundImages arrays)

const TopicExplorer = () => {
  // ... (keep existing state variables and useEffect)

  const renderContent = () => {
    if (currentSubtopic) {
      return (
        <>
          <h2 className="text-2xl font-semibold mb-4 text-[#1c2636]">{currentSubtopic.title}</h2>
          <p className="text-[#1c2636] text-base leading-relaxed mb-4">{currentSubtopic.description}</p>
          <div className="mt-4">
            <h3 className="text-xl font-semibold mb-2 text-[#1c2636]">Content:</h3>
            <p className="text-[#1c2636]">{currentSubtopic.content}</p>
          </div>
        </>
      );
    } else {
      return (
        <>
          <h2 className="text-2xl font-semibold mb-4 text-[#1c2636]">{currentTopic.title}</h2>
          <p className="text-[#1c2636] text-base leading-relaxed mb-4">{currentTopic.content}</p>
        </>
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
      <div className="absolute inset-0 bg-black bg-opacity-50" />

      {/* Content */}
      <div className="relative z-10 min-h-screen flex flex-col">
        <header className="bg-[#1c2636] bg-opacity-80 text-white p-4">
          <h1 className="text-3xl font-bold">Offshore Wind Farm Explorer</h1>
        </header>

        <div className="flex-grow flex justify-center items-start p-8 gap-8">
          {/* Main Content */}
          <div className="w-[45%] max-w-xl">
            <div className="bg-white bg-opacity-90 p-6 rounded-lg shadow-lg backdrop-blur-md">
              {renderContent()}
              
              {/* Deep Dive Options */}
              <div className="mt-8">
                <h3 className="text-xl font-semibold mb-3 text-[#1c2636]">Deep Dive</h3>
                <ul className="space-y-2">
                  {currentTopic.subtopics.map((subtopic, index) => (
                    <li key={index}>
                      <button
                        onClick={() => handleSubtopicClick(subtopic)}
                        className="w-full text-left bg-blue-50 hover:bg-blue-100 transition-colors duration-300 p-2 rounded shadow text-sm"
                      >
                        <span className="font-medium text-blue-800">
                          {`Deep dive into ${subtopic.title.toLowerCase()}`}
                        </span>
                      </button>
                    </li>
                  ))}
                </ul>
              </div>

              {/* Additional Resources */}
              <div className="mt-8">
                <h3 className="text-xl font-semibold mb-4 text-[#1c2636]">Additional Resources</h3>
                {Object.entries(currentTopic.resources).map(([type, items]) => (
                  <div key={type} className="mb-4">
                    <h4 className="text-lg font-semibold mb-2 flex items-center text-[#1c2636]">
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

              {/* Next Topic */}
              <div className="mt-8">
                <h3 className="text-xl font-semibold mb-2 text-[#1c2636]">Next Topic</h3>
                <button
                  onClick={() => handleTopicChange(topics[(topics.findIndex(t => t.title === currentTopic.title) + 1) % topics.length])}
                  className="w-full text-left bg-green-50 hover:bg-green-100 transition-colors duration-300 p-2 rounded shadow"
                >
                  <span className="font-medium text-green-800">Explore Next Topic</span>
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