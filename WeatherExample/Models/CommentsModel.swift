//
//  CommentsModel.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation

struct CommentsModel:Codable {
    let postID, id: Int?
    let name, email, body: String?
}
