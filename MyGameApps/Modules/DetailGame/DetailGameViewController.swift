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
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    var data: DetailGame?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = id {
            viewModel.getDetailGame(withId: id)
        }
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
                self.reloadUI()
            }
        }
    }
    @IBAction func bakcButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    func reloadUI() {
        activityIndicator.isHidden = true
        rootView.isHidden = false
        imageGame.sd_setImage(with: URL(string: data?.backgroundImage ?? ""))
        gameName.text = data?.name
        releaseDate.text = data?.released
        gameDescription.setLineSpacing(lineSpacing: 1.5)
        gameDescription.text = data?.descriptionRaw
        gameRating.text = String(data?.rating ?? 0)
    }
}
