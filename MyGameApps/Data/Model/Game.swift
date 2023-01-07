//
//  Game.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import Foundation

struct GameResponses: Codable {
    let results: [Game]?
}

struct Game: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let genres: [Genres]?
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case genres
    }
}

struct Genres: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
