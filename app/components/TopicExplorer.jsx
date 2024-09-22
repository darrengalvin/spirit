'use client';

import React, { useState } from 'react';
import { ChevronRight, Video, BookOpen, FileDown, ArrowRight } from 'lucide-react';

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
        
        5. J-tube and Cable Entry Inspections: Checking the condition of cable entry points and protective J-tubes.
        
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
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_wind_Vessel_photo_lufka3.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_wind_maintenance_photo_zgmlwl.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_wind_foundation_photo_sskion.png",
  "https://res.cloudinary.com/dplpckpbm/image/upload/v1726968779/windfarms/Offshore_Wind_Turbine_Generator_ztpavk.png"
];

const TopicExplorer = () => {
  const [currentTopic, setCurrentTopic] = useState(topics[0]);
  const [currentSubtopic, setCurrentSubtopic] = useState(null);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [isTransitioning, setIsTransitioning] = useState(false);

  const handleSubtopicClick = (subtopic) => {
    setCurrentSubtopic(subtopic);
    changeBackgroundImage();
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
    <div className="flex flex-col h-screen overflow-hidden bg-gray-100">
      {/* Fixed Header */}
      <header className="bg-[#1c2636] text-white p-4 shadow-md z-10">
        <h1 className="text-2xl lg:text-3xl font-bold">Offshore Wind Farm Explorer</h1>
      </header>

      {/* Content Area */}
      <div className="flex flex-col lg:flex-row flex-grow overflow-hidden">
        {/* Left Content Area */}
        <div className="w-full lg:w-2/3 overflow-y-auto p-4 lg:p-8">
          {/* Main Content */}
          <div className="bg-white p-4 lg:p-6 rounded-lg shadow-lg mb-4 lg:mb-8">
            {renderContent()}
            
            <div className="mt-4 lg:mt-8">
              <h3 className="text-lg lg:text-xl font-semibold mb-2 lg:mb-3 text-[#1c2636]">Deep Dive</h3>
              <ul className="space-y-2">
                {currentTopic.subtopics.map((subtopic, index) => (
                  <li key={index}>
                    <button
                      onClick={() => handleSubtopicClick(subtopic)}
                      className="w-full text-left bg-blue-50 hover:bg-blue-100 transition-colors duration-300 p-2 rounded shadow text-sm lg:text-base"
                    >
                      <span className="font-medium text-blue-800">
                        {`Deep dive into ${subtopic.title.toLowerCase()}`}
                      </span>
                    </button>
                  </li>
                ))}
              </ul>
            </div>
          </div>

          {/* Additional Resources */}
          <div className="bg-white p-4 lg:p-6 rounded-lg shadow-lg mb-4 lg:mb-8">
            <h3 className="text-lg lg:text-2xl font-semibold mb-2 lg:mb-4 text-[#1c2636]">Additional Resources</h3>
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
                    <li key={index} className="text-blue-600 hover:underline cursor-pointer text-sm lg:text-base">{item}</li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>

        {/* Right Image Area */}
        <div className="w-full lg:w-1/3 relative">
          <div className="h-64 lg:h-full relative">
            <div 
              className={`absolute inset-0 bg-cover bg-center transition-opacity duration-1000 ${isTransitioning ? 'opacity-0' : 'opacity-100'}`}
              style={{ 
                backgroundImage: `url(${backgroundImages[currentImageIndex]})`,
              }}
            />
            <div className="absolute inset-0 bg-black bg-opacity-30" />
          </div>
          
          {/* Enhanced Next Topic Card */}
          <div className="absolute bottom-0 left-0 right-0 bg-green-100 p-4 lg:p-6">
            <h3 className="text-lg lg:text-xl font-semibold mb-2 text-green-800">Ready to Explore More?</h3>
            <p className="text-green-700 mb-4 text-sm lg:text-base">Dive into the next exciting topic in offshore wind farming.</p>
            <button
              onClick={() => handleTopicChange(topics[(topics.findIndex(t => t.title === currentTopic.title) + 1) % topics.length])}
              className="w-full bg-green-500 text-white py-2 px-4 rounded hover:bg-green-600 transition-colors duration-300 flex items-center justify-center text-sm lg:text-base"
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