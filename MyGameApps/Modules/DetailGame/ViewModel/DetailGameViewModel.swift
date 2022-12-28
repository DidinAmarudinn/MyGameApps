//
//  DetailGameViewModel.swift
//  MyGameApps
//
//  Created by didin amarudin on 28/12/22.
//

import Foundation

protocol DetailGameViewModelProtocol {
    func getDetailGame(withId id: Int)
    var didFinishedGetDetailGame: ((_ data: DetailGame?, _ error: String?) -> Void)? { get set }
}
class DetailGameViewModel: DetailGameViewModelProtocol {
    var didFinishedGetDetailGame: ((DetailGame?, String?) -> Void)?
    let service: ApiService
    init(service: ApiService) {
        self.service = service
    }
    func getDetailGame(withId id: Int) {
        Task {
            let result = try await service.getDetailGame(id: id)
            switch result {
            case .success(let response):
                didFinishedGetDetailGame?(response, nil)
            case .failure(let failure):
                didFinishedGetDetailGame?(nil, failure.customMessage)
            }
        }
    }
}
