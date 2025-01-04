//
//  PlaceService.swift
//  SWE_Project
//
//  Created by Khalid R on 25/03/1446 AH.
//
import Foundation
import Combine

class PlaceService {
    @Published var allPlaces: [PlaceModel] = []
    var placeSub: AnyCancellable?

    func loadLocalData() {
        // Ensure the file exists in the main bundle
        guard let url = Bundle.main.url(forResource: "Data", withExtension: "json") else {
            print("DEBUG: JSON file not found.")
            return
        }
        
        // Load the data from the file
        do {
            let data = try Data(contentsOf: url)
            let decodedPlaces = try JSONDecoder().decode([PlaceModel].self, from: data)
            self.allPlaces = decodedPlaces
            print("DEBUG: Data loaded successfully from local JSON file")
        } catch {
            print("DEBUG: Error decoding JSON: \(error)")
        }
    }
}
