//
//  UserLocation.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation

struct UserLocation : Codable {
    let request : Request?
    let location : Location?
    let current : Current?

    enum CodingKeys: String, CodingKey {

        case request = "request"
        case location = "location"
        case current = "current"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        request = try values.decodeIfPresent(Request.self, forKey: .request)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        current = try values.decodeIfPresent(Current.self, forKey: .current)
    }

}
