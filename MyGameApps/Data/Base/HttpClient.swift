//
//  HttpClient.swift
//  MyGameApps
//
//  Created by didin amarudin on 26/12/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> Result<T, ErrorRequest>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> Result<T, ErrorRequest> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems.compactMapValues({
                if let value = $0 as? String {
                    return value
                } else {
                    return "\($0)"
                }
        }).map({ URLQueryItem(name: $0.key, value: $0.value) })
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }
       
        switch response.statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            guard let decodeResponse = try? decoder.decode(responseModel, from: data) else {
                return .failure(.decode)
            }
            print(decodeResponse)
            return .success(decodeResponse)
        default:
            return .failure(.unknown)
        }
    }
}
