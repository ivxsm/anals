//
//  WeatherModel.swift
//  SWE_Project
//
//  Created by Khalid R on 20/03/1446 AH.
//


import Foundation

struct WeatherModel: Codable {
    let temperature: Double
    let description: String
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case description = "weather"
        case cityName = "name"
    }
    
    struct WeatherCondition: Codable {
        let main: String
        let description: String
    }
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct WeatherResponse: Codable {
        let weather: [WeatherCondition]
        let main: Main
        let name: String
    }
}
