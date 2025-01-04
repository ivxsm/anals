//
//  WeatherService.swift
//  SWE_Project
//
//  Created by Khalid R on 20/03/1446 AH.
//
import Foundation

class WeatherService {
    private let apiKey = "bb531faa9bdf75eaf96dcb71914a91de" // Replace with your actual API key
    
    func fetchWeather(for city: String, completion: @escaping (WeatherModel?) -> Void) {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather:", error?.localizedDescription ?? "")
                completion(nil)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherModel.WeatherResponse.self, from: data)
                let weather = WeatherModel(
                    temperature: weatherResponse.main.temp,
                    description: weatherResponse.weather.first?.description ?? "Unknown",
                    cityName: weatherResponse.name
                )
                
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch {
                print("Failed to decode weather data:", error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
