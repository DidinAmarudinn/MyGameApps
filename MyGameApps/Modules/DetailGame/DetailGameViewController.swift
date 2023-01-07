//
//  DetailGameViewController.swift
//  MyGameApps
//
//  Created by didin amarudin on 28/12/22.
//

import UIKit
import SDWebImage
class DetailGameViewController: UIViewController {
    let viewModel: DetailGameViewModel = DetailGameViewModel(service: ApiServiceImpl())
    var id: Int?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var rootView: UIStackView!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    var isFavorite: Bool = false
    var data: DetailGame?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = id {
            viewModel.getDetailGame(withId: id)
        }
        activityIndicator.startAnimating()
        self.navigationController?.isNavigationBarHidden = true
        rootView.isHidden = true
        viewModel.didFinishedGetDetailGame = didFinishedGetDetailGame
    }
    private func didFinishedGetDetailGame(_ data: DetailGame?, _ error: String?) {
        if let error = error {
            DispatchQueue.main.async {
                self.view.makeToast(error)
            }
        } else {
            DispatchQueue.main.async {
                self.data = data
                if let data = data {
                    GameProvider().checkIsFavorite(data.id!) { isFavorite in
                        self.isFavorite = isFavorite
                        if isFavorite {
                            DispatchQueue.main.async {
                                self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                            }
                        }
                    }
                }
                self.reloadUI()
            }
        }
    }
    @IBAction func bakcButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    func reloadUI() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        rootView.isHidden = false
        imageGame.sd_setImage(with: URL(string: data?.backgroundImage ?? ""))
        imageGame.setGradientBackground(colorTop: UIColor.black.withAlphaComponent(0.2), colorBottom: UIColor.black.withAlphaComponent(0.2), colorMid: UIColor.black.withAlphaComponent(0))
        gameName.text = data?.name
        releaseDate.text = data?.released
        gameDescription.setLineSpacing(lineSpacing: 1.5)
        gameDescription.text = data?.descriptionRaw
        gameRating.text = String(data?.rating ?? 0)
    }
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if let data = data {
                if (isFavorite) {
                    GameProvider().deleteFromFavorite(data.id!) {
                        DispatchQueue.main.async {
                            self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                            let alert = UIAlertController(title: "Successful", message: "Removed from favorite", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.present(alert, animated: true)
                        }
                    }
                } else {
                    guard let imageData = self.imageGame.image?.jpegData(compressionQuality: 0.5) else {
                        return
                    }
                    GameProvider().addToFavorite(data, imageData) {
                        DispatchQueue.main.async {
                            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                            let alert = UIAlertController(title: "Successful", message: "Added to favorite", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.present(alert, animated: true)
                        }
                    }
            }
        }
    }
}
