//
//  WeatherViewModel.swift
//  SWE_Project
//
//  Created by Khalid R on 20/03/1446 AH.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var riyadhWeather: WeatherModel?
    @Published var jeddahWeather: WeatherModel?
    
    private let weatherService = WeatherService()
    
    func fetchWeather(for city: City) {
        switch city {
        case .riyadh:
            weatherService.fetchWeather(for: "Riyadh") { [weak self] weather in
                self?.riyadhWeather = weather
            }
        case .jeddah:
            weatherService.fetchWeather(for: "Jeddah") { [weak self] weather in
                self?.jeddahWeather = weather
            }
        }
    }
    
    func getTemperature(for city: City) -> Double {
        switch city {
        case .riyadh:
            return riyadhWeather?.temperature ?? 0.0
        case .jeddah:
            return jeddahWeather?.temperature ?? 0.0
        }
    }
    
    func getDayOrNightImage() -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        // If the current hour is between 5 AM and 3 PM, show Sun, else Moon
        if currentHour >= 5 && currentHour <= 15 {
            return "Sun"
        } else {
            return "Moon"
        }
    }
}


