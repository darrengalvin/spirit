import '../styles/globals.css'
import type { Metadata } from 'next'
import dynamic from 'next/dynamic'
import { Poppins } from 'next/font/google'

const ClientLayout = dynamic(() => import('./ClientLayout'), { ssr: false })

const poppins = Poppins({
  subsets: ['latin'],
  weight: ['400', '500', '600', '700'],
  display: 'swap',
})

export const metadata: Metadata = {
  title: 'Spirit.YourCAIO.co.uk',
  description: 'Powered by Next.js',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" className={poppins.className}>
      <body>{children}</body>
    </html>
  )
}