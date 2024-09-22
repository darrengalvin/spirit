import React from 'react';
import { Card, CardContent, CardHeader } from '../components/ui/card';

export default function ImprovedWindFarmExplorer() {
  return (
    <div className="relative h-screen w-full bg-[url('/api/placeholder/1920/1080')] bg-cover bg-center">
      <div className="absolute inset-0 bg-black bg-opacity-50 backdrop-blur-sm">
        <div className="container mx-auto p-8 flex">
          <div className="w-1/2">
            <Card className="bg-white bg-opacity-90 text-gray-800 shadow-lg">
              <CardHeader>
                <h2 className="text-2xl font-bold text-gray-900">Foundations</h2>
              </CardHeader>
              <CardContent>
                <p className="mb-4 text-gray-700">
                  Foundations are critical components in offshore wind farms, providing stability and support for wind turbines in challenging marine environments. They are designed to withstand extreme weather conditions, tidal forces, and the weight of the turbine structure.
                </p>
                <h3 className="text-xl font-semibold mb-2 text-gray-900">Additional Resources</h3>
                <div className="space-y-4">
                  <div>
                    <h4 className="font-medium text-gray-800">Videos to Watch</h4>
                    <ul className="list-disc list-inside text-gray-700">
                      <li>Types of Offshore Wind Foundations</li>
                      <li>Foundation Installation Process</li>
                      <li>Subsea Inspection Techniques</li>
                    </ul>
                  </div>
                  <div>
                    <h4 className="font-medium text-gray-800">Course Content</h4>
                    <ul className="list-disc list-inside text-gray-700">
                      <li>Offshore Foundation Design</li>
                      <li>Preventative Maintenance for Offshore Structures</li>
                      <li>ROV Operation for Subsea Inspections</li>
                    </ul>
                  </div>
                  <div>
                    <h4 className="font-medium text-gray-800">Files to Download</h4>
                    <ul className="list-disc list-inside text-gray-700">
                      <li>Foundation Maintenance Guide.pdf</li>
                      <li>Offshore Wind Foundation Types.pdf</li>
                      <li>Logistics Planning for Foundation Transport.pdf</li>
                    </ul>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}