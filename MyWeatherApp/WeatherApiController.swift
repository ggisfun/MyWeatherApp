//
//  WeatherApiController.swift
//  MyWeatherApp
//
//  Created by Adam Chen on 2024/10/25.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    
    private init() {
    }
    
    private let apiKey = "apiKey"
    
    enum WeatherError: Error {
        case invalidURL
        case networkError(Error)
        case decodingError(Error)
        case noData
        case invalidResponse
    }
    
    func fetchWeatherData(for coordinate: String, completion: @escaping (Result<WeatherResponse, WeatherError>) -> Void) {
        
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(coordinate)?key=\(apiKey)&unitGroup=metric&contentType=json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
