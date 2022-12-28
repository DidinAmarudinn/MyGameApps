//
//  Endpoint.swift
//  MyGameApps
//
//  Created by didin amarudin on 26/12/22.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [String: Any] { get }
    var method: RequestMethod { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.rawg.io"
    }
}
