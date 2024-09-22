import dynamic from 'next/dynamic';

const TopicExplorer = dynamic(() => import('../components/TopicExplorer'), { 
  loading: () => <p>Loading...</p>,
  ssr: false 
});

export default function LearningPage() {
  return (
    <div>
      <TopicExplorer />
    </div>
  )
}