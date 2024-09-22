import React from 'react'
import Link from 'next/link'

const SideMenu: React.FC = () => {
  return (
    <nav className="bg-gray-800 text-white w-64 min-h-screen p-4">
      <h2 className="text-2xl font-bold mb-4">Spirit</h2>
      <ul>
        <li className="mb-2">
          <Link href="/" className="hover:text-gray-300">
            Home
          </Link>
        </li>
        <li className="mb-2">
          <Link href="/about" className="hover:text-gray-300">
            About
          </Link>
        </li>
        <li className="mb-2">
          <Link href="/services" className="hover:text-gray-300">
            Services
          </Link>
        </li>
        <li className="mb-2">
          <Link href="/contact" className="hover:text-gray-300">
            Contact
          </Link>
        </li>
      </ul>
    </nav>
  )
}

export default SideMenu