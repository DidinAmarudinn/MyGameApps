//
//  FavoriteGamesViewController.swift
//  MyGameApps
//
//  Created by didin amarudin on 06/01/23.
//

import UIKit

class FavoriteGamesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private lazy var gameProvider: GameProvider = { return GameProvider() }()
    var list: [GameDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllFavoriteGames()
    }
    func getAllFavoriteGames() {
        self.gameProvider.getAllFavoritesGames { games in
            DispatchQueue.main.async {
                self.list = games
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier:  "FavoriteTableViewCell")
    }
    func delete(id: Int) {
        self.gameProvider.deleteFromFavorite(id) {
            DispatchQueue.main.async {
                print("Deleted")
                self.getAllFavoriteGames()
                self.tableView.reloadData()
            }
        }
    }
}

extension FavoriteGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell {
            let data = list[indexPath.row]
            cell.data = data
            cell.setupUI()
            cell.onDelete = {
                self.delete(id: Int(data.id!))
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailGameViewController()
        vc.id = Int(list[indexPath.row].id ?? 0)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true, completion: nil)
    }
    
}
