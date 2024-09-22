'use client';
import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { BookOpen, ChevronRight, ChevronLeft } from 'lucide-react';

export default function SpiritSideMenu({ onExpand }) {
  const [isExpanded, setIsExpanded] = useState(false);
  const [isPinned, setIsPinned] = useState(false);
  const [isMobile, setIsMobile] = useState(false);
  const pathname = usePathname();

  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 768);
    };
    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  const handleMouseEnter = () => {
    if (!isPinned && !isMobile) {
      setIsExpanded(true);
      onExpand(true);
    }
  };

  const handleMouseLeave = () => {
    if (!isPinned && !isMobile) {
      setIsExpanded(false);
      onExpand(false);
    }
  };

  const togglePin = () => {
    if (!isMobile) {
      setIsPinned(!isPinned);
      setIsExpanded(!isPinned);
      onExpand(!isPinned);
    }
  };

  if (isMobile) {
    return null; // Hide the side menu on mobile
  }

  return (
    <nav 
      className={`fixed top-0 left-0 h-full bg-gray-100 transition-all duration-300 ease-in-out ${isExpanded ? 'w-64' : 'w-20'}`}
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
    >
      <div className="flex justify-end p-2">
        <button onClick={togglePin} className="text-gray-600 hover:text-gray-800">
          {isPinned ? <ChevronLeft size={20} /> : <ChevronRight size={20} />}
        </button>
      </div>
      <ul className="space-y-2 pt-2">
        <li>
          <Link href="/learning" className={`flex items-center p-2 space-x-3 rounded-md ${
            pathname === '/learning' ? 'bg-blue-100 text-blue-600' : 'text-gray-600 hover:bg-gray-200 hover:text-gray-800'
          }`}>
            <div className={`flex items-center justify-center ${isExpanded ? 'w-6' : 'w-full'}`}>
              <BookOpen size={isExpanded ? 20 : 24} className="text-gray-600" />
            </div>
            <span className={`${isExpanded ? 'opacity-100 w-auto' : 'opacity-0 w-0'} transition-all duration-300 overflow-hidden`}>
              Learning
            </span>
          </Link>
        </li>
      </ul>
    </nav>
  );
}
