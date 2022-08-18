//
//  Request.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation

struct Request : Codable {
    let type : String?
    let query : String?
    let language : String?
    let unit : String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case query = "query"
        case language = "language"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        query = try values.decodeIfPresent(String.self, forKey: .query)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }

}
