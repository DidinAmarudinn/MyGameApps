//
//  ListGameViewModel.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import Foundation

protocol ListGameViewModelProtocol {
    func getListGame()
    func getListArcadeGame()
    func getListIndieGame()
    func getListPlatfrom()
    var didFinishedGetListGame: ((_ data: GameResponses?, _ error: String?) -> Void)? { get set }
    var didFinishedGetListArcadeGame: ((_ data: GameResponses?, _ error: String?) -> Void)? { get set }
    var didFinishedGetListIndieGame: ((_ data: GameResponses?, _ error: String?) -> Void)? { get set }
    var didFinishedGetListPlatfrom: ((_ data: PlatfromResponses?, _ error: String?) -> Void)? { get set }
}

class ListGameViewModel: ListGameViewModelProtocol {
    var didFinishedGetListArcadeGame: ((GameResponses?, String?) -> Void)?
    var didFinishedGetListIndieGame: ((GameResponses?, String?) -> Void)?
    var didFinishedGetListGame: ((GameResponses?, String?) -> Void)?
    var didFinishedGetListPlatfrom: ((PlatfromResponses?, String?) -> Void)?
    var listGames: [Game] = []
    let service: ApiService
    init(service: ApiService) {
        self.service = service
    }
    func getListGame() {
        Task {
            let result = try await service.getListActionGame()
            switch result {
            case .success(let gameResponse):
                didFinishedGetListGame?(gameResponse, nil)
            case .failure(let failure):
                didFinishedGetListGame?(nil, failure.customMessage)
            }
        }
    }
    func getListIndieGame() {
        Task {
            let result = try await service.getListIndieGame()
            switch result {
            case .success(let gameResponse):
                didFinishedGetListIndieGame?(gameResponse, nil)
            case .failure(let failure):
                didFinishedGetListIndieGame?(nil, failure.customMessage)
            }
        }
    }
    func getListArcadeGame() {
        Task {
            let result = try await service.getListArcadeGame()
            switch result {
            case .success(let gameResponse):
                didFinishedGetListArcadeGame?(gameResponse, nil)
            case .failure(let failure):
                didFinishedGetListArcadeGame?(nil, failure.customMessage)
            }
        }
    }
    func getListPlatfrom() {
        Task {
            let result = try await service.getListPlatfrom()
            switch result {
            case .success(let platfromResponse):
                didFinishedGetListPlatfrom?(platfromResponse, nil)
            case .failure(let failure):
                didFinishedGetListPlatfrom?(nil, failure.customMessage)
            }
        }
    }
}
