//
//  ErrorRequest.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import Foundation

enum ErrorRequest: Error {
    case decode
    case invalidURL
    case unknown
    case noResponse
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode Error"
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknowm Error"
        case .noResponse:
            return "No Response"
        }
    }
}
