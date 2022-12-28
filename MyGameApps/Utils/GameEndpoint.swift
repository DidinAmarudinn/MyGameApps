//
//  GameEndpoint.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import Foundation

enum GameEndpoint {
    case listGame
    case listActionsGame
    case listArcade
    case listIndie
    case listPlatfrom
    case detailGame(id: Int)
}

extension GameEndpoint: Endpoint {
    var path: String {
        switch self {
        case .listGame:
            return "/api/games"
        case .listActionsGame:
            return "/api/games"
        case .listArcade:
            return "/api/games"
        case .listIndie:
            return "/api/games"
        case .listPlatfrom:
            return "/api/platforms"
        case .detailGame(let id):
            return "/api/games/\(id)"
        }
    }
    var method: RequestMethod {
        switch self {
        case .listGame:
            return .get
        case .listActionsGame:
            return .get
        case .listIndie:
            return .get
        case .listArcade:
            return .get
        case .listPlatfrom:
            return .get
        case .detailGame:
            return .get
        }
    }
    var queryItems: [String : Any] {
        switch self {
        case .listGame:
            let param: [String: Any] = [
                "key" : ApiConstants.apiKey,
                "page_size" : 10
            ]
            return param
        case .listActionsGame:
            let param: [String: Any] = [
                "key" : ApiConstants.apiKey,
                "genres" : "action",
                "page_size" : 10
            ]
            return param
        case .listIndie:
            let param: [String: Any] = [
                "key" : ApiConstants.apiKey,
                "genres" : "indie",
                "page_size" : 10
            ]
            return param
        case .listArcade:
            let param: [String: Any] = [
                "key" : ApiConstants.apiKey,
                "genres" : "arcade",
                "page_size" : 10
            ]
            return param
        case .listPlatfrom:
            let param: [String: Any] = [
                "key" : ApiConstants.apiKey,
                "page_size" : 10
            ]
            return param
        case .detailGame:
            let param: [String: Any] = [
                "key" : ApiConstants.apiKey
            ]
            return param
        }
    }
}
