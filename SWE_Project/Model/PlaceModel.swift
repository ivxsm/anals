//
//  PlaceModel.swift
//  SWE_Project
//
//  Created by Khalid R on 18/03/1446 AH.
//

import Foundation
import CoreLocation

class PlaceModel: Codable, Identifiable {
    var id = UUID()
    var name: String?
    var price: Double?
    var description: String?
    var rate: Double?
    var visitTime: String?
    var images: [String]?
    var typeRaw: String?
    var cityRaw: String?
    var location: Location
    
    
    var type: PlaceType? {
        PlaceType(rawValue: typeRaw?.lowercased() ?? "")
    }
    
    var city: City? {
        City(rawValue: cityRaw?.lowercased() ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "place_name"
        case price
        case description
        case rate
        case visitTime = "visit_time"
        case images
        case typeRaw = "place_type"
        case cityRaw = "city"
        case location
    }

}

// MARK: - Location Struct
struct Location: Codable {
    var latitude: Double
    var longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }
    

}


}

// MARK: - Location Struct
struct Location: Codable {
    var latitude: Double
    var longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }
    

}


enum City: String, CaseIterable {
    case riyadh
    case jeddah

    var title: String {
        switch self {
        case .riyadh: return "Riyadh"
        case .jeddah: return "Jeddah"
        }
    }
}

enum PlaceType: String {
    case restaurant
    case hotel
    case museum
    case entertainment

    var title: String {
        switch self {
        case .restaurant: return "Restaurant"
        case .hotel: return "Hotel"
        case .museum: return "Museum"
        case .entertainment: return "Entertainment"
        }
    }

    var imageName: String {
        switch self {
        case .restaurant: return "Restaurant"
        case .hotel: return "Hotel"
        case .museum: return "Museum"
        case .entertainment: return "Entertainment"
        }
    }
    
    
    

}
