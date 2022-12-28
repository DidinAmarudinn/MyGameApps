//
//  Platfrom.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import Foundation

struct PlatfromResponses: Codable {
    var count: Int?
    var next: String?
    var results: [Platfrom]?
}
struct Platfrom: Codable {
    var id: Int?
    var name: String?
    var slug: String?
    var gamesCount: Int?
    var imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
