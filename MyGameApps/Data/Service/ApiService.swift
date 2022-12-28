//
//  ApiService.swift
//  MyGameApps
//
//  Created by didin amarudin on 26/12/22.
//

import Foundation

protocol ApiService {
    func getListGame() async throws -> Result<GameResponses, ErrorRequest>
    func getListActionGame() async throws -> Result<GameResponses, ErrorRequest>
    func getListArcadeGame() async throws -> Result<GameResponses, ErrorRequest>
    func getListIndieGame() async throws -> Result<GameResponses, ErrorRequest>
    func getListPlatfrom() async throws -> Result<PlatfromResponses, ErrorRequest>
    func getDetailGame(id: Int) async throws -> Result<DetailGame, ErrorRequest>
}

class ApiServiceImpl: ApiService, HTTPClient {
    func getListGame() async throws -> Result<GameResponses, ErrorRequest> {
        return try await sendRequest(endpoint: GameEndpoint.listGame, responseModel: GameResponses.self)
    }
    func getListActionGame() async throws -> Result<GameResponses, ErrorRequest> {
        return try await sendRequest(endpoint: GameEndpoint.listActionsGame, responseModel: GameResponses.self)
    }
    func getListIndieGame() async throws -> Result<GameResponses, ErrorRequest> {
        return try await sendRequest(endpoint: GameEndpoint.listIndie, responseModel: GameResponses.self)
    }
    func getListArcadeGame() async throws -> Result<GameResponses, ErrorRequest> {
        return try await sendRequest(endpoint: GameEndpoint.listArcade, responseModel: GameResponses.self)
    }
    func getListPlatfrom() async throws -> Result<PlatfromResponses, ErrorRequest> {
        return try await sendRequest(endpoint: GameEndpoint.listPlatfrom, responseModel: PlatfromResponses.self)
    }
    func getDetailGame(id: Int) async throws -> Result<DetailGame, ErrorRequest> {
        return try await sendRequest(endpoint: GameEndpoint.detailGame(id: id), responseModel: DetailGame.self)
    }
}
