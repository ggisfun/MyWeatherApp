//
//  WeatherResponse.swift
//  MyWeatherApp
//
//  Created by Adam Chen on 2024/10/25.
//

import Foundation

struct WeatherResponse: Codable {
    let days: [Day]
    let currentConditions: CurrentConditions
}

struct Day: Codable {
    let datetime: String
    let icon: String
    let tempmax: Double
    let tempmin: Double
    let temp: Double
    let precipprob: Double
    let hours: [Hour]
}

struct Hour: Codable {
    let datetime: String
    let temp: Double
    let icon: String
}

struct CurrentConditions: Codable {
    let datetime: String
    let temp: Double
    let precipprob: Double
    let windspeed: Double
    let icon: String
}
