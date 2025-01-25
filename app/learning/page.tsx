import dynamic from 'next/dynamic';

const TopicExplorer = dynamic(() => import('./TopicExplorer'), { 
  loading: () => <p>Loading...</p>,
  ssr: false 
});

export default function LearningPage() {
  return (
    <div className="min-h-screen">
      <TopicExplorer />
    </div>
  )
}