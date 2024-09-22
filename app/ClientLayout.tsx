'use client'

import { useState } from 'react'
import SpiritSideMenu from './components/spiritSideMenu'

export default function ClientLayout({ children }: { children: React.ReactNode }) {
  const [isMenuExpanded, setIsMenuExpanded] = useState(false);

  return (
    <>
      <SpiritSideMenu onExpand={setIsMenuExpanded} />
      <main className={`transition-all duration-300 ${isMenuExpanded ? 'ml-64' : 'ml-20'} p-4`}>
        {children}
      </main>
    </>
  )
}