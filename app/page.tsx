import ImprovedWindFarmExplorer from '../components/ImprovedWindFarmExplorer';
import ChatComponent from '../components/ChatComponent';

export default function HomePage() {
  return (
    <div className="container mx-auto">
      <h1 className="text-2xl font-bold mb-4">Welcome to Spirit.YourCAIO.co.uk</h1>
      <p className="mb-4">Select an option from the side menu to get started.</p>
      <div className="grid gap-8">
        <ChatComponent />
        <ImprovedWindFarmExplorer />
      </div>
    </div>
  )
}