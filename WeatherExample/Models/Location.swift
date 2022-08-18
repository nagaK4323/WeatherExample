//
//  Location.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation

struct Location : Codable {
    let name : String?
    let country : String?
    let region : String?
    let lat : String?
    let lon : String?
    let timezone_id : String?
    let localtime : String?
    let localtime_epoch : Int?
    let utc_offset : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case country = "country"
        case region = "region"
        case lat = "lat"
        case lon = "lon"
        case timezone_id = "timezone_id"
        case localtime = "localtime"
        case localtime_epoch = "localtime_epoch"
        case utc_offset = "utc_offset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        timezone_id = try values.decodeIfPresent(String.self, forKey: .timezone_id)
        localtime = try values.decodeIfPresent(String.self, forKey: .localtime)
        localtime_epoch = try values.decodeIfPresent(Int.self, forKey: .localtime_epoch)
        utc_offset = try values.decodeIfPresent(String.self, forKey: .utc_offset)
    }

}
