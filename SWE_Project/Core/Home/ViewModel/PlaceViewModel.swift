//
//  PlaceViewModel.swift
//  SWE_Project
//
//  Created by Khalid R on 25/03/1446 AH.
//
import Foundation
import Combine

class PlaceViewModel: ObservableObject {
    @Published var places: [PlaceModel] = []  // Filtered places to display
    @Published var selectedCategory: Category = .popular
    @Published var selectedCity: City = .riyadh
    @Published var searchText: String = ""

    @Published var planPlaces: [PlaceModel] = []
    @Published var selectedPlan: Int = 1

    private var placeService = PlaceService()
    private var cancellables = Set<AnyCancellable>()
    private var allPlaces: [PlaceModel] = []  // All loaded places

    init() {

        addSubscribers()
    }

    private func addSubscribers() {
        placeService.loadLocalData()
        
        placeService.$allPlaces
            .sink { [weak self] places in
                self?.allPlaces = places
                self?.filterPlaces()
            }
            .store(in: &cancellables)
        
        // Observe changes in category, city, and searchText to refilter places
        $selectedCategory
            .combineLatest($selectedCity, $searchText)
            .sink { [weak self] category, city, search in
                self?.filterPlaces()
            }
            .store(in: &cancellables)
    }

    // Function to filter places based on selected category and city
    private func filterPlaces() {
        var filteredPlaces = allPlaces
        
        // Filter by selected city
        filteredPlaces = filteredPlaces.filter { $0.city == selectedCity }
        
        // Filter by selected category (only if not "Popular")
        if selectedCategory != .popular {
            filteredPlaces = filteredPlaces.filter { $0.type?.rawValue == selectedCategory.rawValue.lowercased() }
        }
        
        // Apply search text if needed
        if !searchText.isEmpty {
            filteredPlaces = filteredPlaces.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
        }

        // If popular category, shuffle and take 15 items
        if selectedCategory == .popular {
            filteredPlaces = Array(filteredPlaces.shuffled().prefix(15))
        }
        
        places = filteredPlaces
    }

    
    func placesForPlan(plan: Int) -> [PlaceModel] {
        // Return places based on the selected plan
        var filteredPlaces = places.shuffled() // Shuffle places
        let firstHotel = filteredPlaces.first(where: { $0.type == .hotel })
        filteredPlaces.removeAll(where: { $0.type == .hotel })
        
        // Ensure first place is hotel, and then other places follow
        var planPlaces: [PlaceModel] = []
        if let hotel = firstHotel {
            planPlaces.append(hotel)
        }
        planPlaces.append(contentsOf: filteredPlaces.prefix(3))
        return planPlaces
    }
    
    func fillPlacesForPlan(plan: Int) {

        var filteredPlaces = places.shuffled()
        

        let firstHotel = filteredPlaces.first(where: { $0.type == .hotel })
        filteredPlaces.removeAll(where: { $0.type == .hotel })
        

        planPlaces = []
        if let hotel = firstHotel {
            planPlaces.append(hotel)
        }
        
        planPlaces.append(contentsOf: filteredPlaces.prefix(3))
    }

}

enum Category: String, CaseIterable {
    case popular = "Popular"
    case hotel = "Hotel"
    case restaurant = "Restaurant"
    case museum = "Museum"
    case entertainment = "Entertainment"
    
    var displayName: String {
        self.rawValue
    }
}
