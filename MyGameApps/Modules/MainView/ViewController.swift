//
//  ViewController.swift
//  MyGameApps
//
//  Created by didin amarudin on 26/12/22.
//

import UIKit
import Toast_Swift
class ViewController: UIViewController {
    let viewModel: ListGameViewModel = ListGameViewModel(service: ApiServiceImpl())
    @IBOutlet var actionGamesCollectionView: UICollectionView!
    @IBOutlet weak var indieGamesCollectionView: UICollectionView!
    @IBOutlet weak var arcadeGamesCollectionView: UICollectionView!
    @IBOutlet weak var platfromCollectionView: UICollectionView!
    var listGames: [Game] = []
    var listArcadeGames: [Game] = []
    var listIndieGames: [Game] = []
    var listPlatfrom: [Platfrom] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didFinishedGetListGame = didFinishedGetGames
        viewModel.didFinishedGetListIndieGame = didFinishedGetListIndieGames
        viewModel.didFinishedGetListArcadeGame = didFinishedGetListArcadeGames
        viewModel.didFinishedGetListPlatfrom = didFinishedGetPlatfrom
        viewModel.getListIndieGame()
        viewModel.getListArcadeGame()
        viewModel.getListPlatfrom()
        viewModel.getListGame()
        setupCollectionView()
    }
    func setupCollectionView() {
        actionGamesCollectionView.delegate = self
        actionGamesCollectionView.dataSource = self
        indieGamesCollectionView.delegate = self
        indieGamesCollectionView.dataSource = self
        arcadeGamesCollectionView.delegate = self
        arcadeGamesCollectionView.dataSource = self
        platfromCollectionView.delegate = self
        platfromCollectionView.dataSource = self
        let nib = UINib(nibName: "GamesCollectionViewCell", bundle: nil)
        let nibPlatfrom = UINib(nibName: "PlatfromCollectionViewCell", bundle: nil)
        actionGamesCollectionView?.register(nib, forCellWithReuseIdentifier: "GamesCollectionViewCell")
        indieGamesCollectionView?.register(nib, forCellWithReuseIdentifier: "GamesCollectionViewCell")
        arcadeGamesCollectionView?.register(nib, forCellWithReuseIdentifier: "GamesCollectionViewCell")
        platfromCollectionView?.register(nibPlatfrom, forCellWithReuseIdentifier: "PlatfromCollectionViewCell")
        let inset: UIEdgeInsets =  UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
        actionGamesCollectionView.contentInset = inset
        arcadeGamesCollectionView.contentInset = inset
        indieGamesCollectionView.contentInset = inset
        platfromCollectionView.contentInset = inset
    }
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        let vc = AboutViewController()
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true, completion: nil)
    }
    private func didFinishedGetGames(_ data: GameResponses?, _ error: String?) {
        if let error = error {
            DispatchQueue.main.async {
                self.view.makeToast(error)
            }
        } else {
            DispatchQueue.main.async {
                self.listGames = data?.results ?? []
                self.actionGamesCollectionView.reloadData()
            }
        }
    }
    private func didFinishedGetListArcadeGames(_ data: GameResponses?, _ error: String?) {
        if let error = error {
            DispatchQueue.main.async {
                self.view.makeToast(error)
            }
        } else {
            DispatchQueue.main.async {
                self.listArcadeGames = data?.results ?? []
                self.arcadeGamesCollectionView.reloadData()
            }
        }
    }
    private func didFinishedGetListIndieGames(_ data: GameResponses?, _ error: String?) {
        if let error = error {
            DispatchQueue.main.async {
                self.view.makeToast(error)
            }
        } else {
            DispatchQueue.main.async {
                self.listIndieGames = data?.results ?? []
                self.indieGamesCollectionView.reloadData()
            }
        }
    }
    private func didFinishedGetPlatfrom(_ data: PlatfromResponses?, _ error: String?) {
        if let error = error {
            DispatchQueue.main.async {
                self.view.makeToast(error)
            }
        } else {
            DispatchQueue.main.async {
                self.listPlatfrom = data?.results ?? []
                self.platfromCollectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == actionGamesCollectionView {
            return listGames.count
        } else if collectionView == indieGamesCollectionView {
            return listIndieGames.count
        } else if collectionView == arcadeGamesCollectionView {
            return listArcadeGames.count
        } else {
            return listPlatfrom.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != self.platfromCollectionView {
            var id: Int?
            if collectionView == actionGamesCollectionView {
                id = listGames[indexPath.row].id
            } else if collectionView == arcadeGamesCollectionView {
                id = listArcadeGames[indexPath.row].id
            } else {
                id = listIndieGames[indexPath.row].id
            }
            let vc = DetailGameViewController()
            vc.id = id
            let nv = UINavigationController(rootViewController: vc)
            nv.modalPresentationStyle = .fullScreen
            self.present(nv, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == actionGamesCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCollectionViewCell",for: indexPath) as? GamesCollectionViewCell {
                cell.data = listGames[indexPath.row]
                cell.setupUI()
                return cell
            }
            return UICollectionViewCell()
        } else if collectionView == indieGamesCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCollectionViewCell",for: indexPath) as? GamesCollectionViewCell {
                cell.data = listIndieGames[indexPath.row]
                cell.setupUI()
                return cell
            }
            return UICollectionViewCell()
        } else if collectionView == arcadeGamesCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCollectionViewCell",for: indexPath) as? GamesCollectionViewCell {
                cell.data = listArcadeGames[indexPath.row]
                cell.setupUI()
                return cell
            }
            return UICollectionViewCell()
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatfromCollectionViewCell",for: indexPath) as? PlatfromCollectionViewCell {
                cell.data = listPlatfrom[indexPath.row]
                cell.setupUI()
                return cell
            }
            return UICollectionViewCell()
        }
    }
}
