import '../styles/globals.css'
import type { Metadata } from 'next'
import dynamic from 'next/dynamic'

const ClientLayout = dynamic(() => import('./ClientLayout'), { ssr: false })

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
    <html lang="en">
      <body className="bg-gray-100 text-gray-900">
        <ClientLayout>{children}</ClientLayout>
      </body>
    </html>
  )
}