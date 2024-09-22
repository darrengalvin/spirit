import ImprovedWindFarmExplorer from '../components/ImprovedWindFarmExplorer';

export default function HomePage() {
  return (
    <div>
      <h1 className="text-2xl font-bold mb-4">Welcome to Spirit.YourCAIO.co.uk</h1>
      <p className="mb-4">Select an option from the side menu to get started.</p>
      <ImprovedWindFarmExplorer />
    </div>
  )
}