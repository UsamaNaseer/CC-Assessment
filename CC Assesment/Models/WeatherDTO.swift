//
//  WeatherDTO.swift
//  CC Assesment
//
//  Created by Usama Naseer on 22/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation
// MARK: - WeatherDTO
struct WeatherListDTO: Codable {
    let list: [WeatherDTO]?
    let cod: String?
}


struct WeatherDTO: Codable {
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let sys: Sys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main,weather, clouds, wind, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: String?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}

struct WeatherInput {
    let lat,long: Double?
}

struct WeatherData {
    let humidity, clouds, wind, temp, tempDesc, day, image : String
}
struct ForecastWeather {
    let image, minmaxTemp, day: String
}
