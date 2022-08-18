//
//  Current.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation

struct Current : Codable {
    let observation_time : String?
    let temperature : Int?
    let weather_code : Int?
    let weather_icons : [String]?
    let weather_descriptions : [String]?
    let wind_speed : Int?
    let wind_degree : Int?
    let wind_dir : String?
    let pressure : Int?
    let precip : Double?
    let humidity : Int?
    let cloudcover : Int?
    let feelslike : Int?
    let uv_index : Int?
    let visibility : Int?
    let is_day : String?

    enum CodingKeys: String, CodingKey {

        case observation_time = "observation_time"
        case temperature = "temperature"
        case weather_code = "weather_code"
        case weather_icons = "weather_icons"
        case weather_descriptions = "weather_descriptions"
        case wind_speed = "wind_speed"
        case wind_degree = "wind_degree"
        case wind_dir = "wind_dir"
        case pressure = "pressure"
        case precip = "precip"
        case humidity = "humidity"
        case cloudcover = "cloudcover"
        case feelslike = "feelslike"
        case uv_index = "uv_index"
        case visibility = "visibility"
        case is_day = "is_day"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        observation_time = try values.decodeIfPresent(String.self, forKey: .observation_time)
        temperature = try values.decodeIfPresent(Int.self, forKey: .temperature)
        weather_code = try values.decodeIfPresent(Int.self, forKey: .weather_code)
        weather_icons = try values.decodeIfPresent([String].self, forKey: .weather_icons)
        weather_descriptions = try values.decodeIfPresent([String].self, forKey: .weather_descriptions)
        wind_speed = try values.decodeIfPresent(Int.self, forKey: .wind_speed)
        wind_degree = try values.decodeIfPresent(Int.self, forKey: .wind_degree)
        wind_dir = try values.decodeIfPresent(String.self, forKey: .wind_dir)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        precip = try values.decodeIfPresent(Double.self, forKey: .precip)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        cloudcover = try values.decodeIfPresent(Int.self, forKey: .cloudcover)
        feelslike = try values.decodeIfPresent(Int.self, forKey: .feelslike)
        uv_index = try values.decodeIfPresent(Int.self, forKey: .uv_index)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        is_day = try values.decodeIfPresent(String.self, forKey: .is_day)
    }

}
