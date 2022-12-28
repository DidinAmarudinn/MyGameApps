//
//  DetailGame.swift
//  MyGameApps
//
//  Created by didin amarudin on 28/12/22.
//

import Foundation
struct DetailGame: Codable {
    var id: Int?
    var slug: String?
    var name: String?
    var nameOriginal: String?
    var platfromResponseDescription: String?
    var released: String?
    var updated: String?
    var backgroundImage: String?
    var backgroundImageAdditional: String?
    var website: String?
    var rating: Double?
    var ratingTop: Int?
    var ratings: [Rating]?
    var publishers: [Publisher]?
    var descriptionRaw: String?
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case nameOriginal = "name_original"
        case platfromResponseDescription = "description"
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website
        case rating
        case ratingTop = "rating_top"
        case ratings
        case publishers
        case descriptionRaw = "description_raw"
    }
}
struct Publisher: Codable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var domain: String?
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain
    }
}
struct Rating: Codable {
    var id: Int?
    var title: String?
    var count: Int?
    var percent: Double?
}

