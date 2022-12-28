//
//  GamesCollectionViewCell.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import UIKit
import SDWebImage
class GamesCollectionViewCell: UICollectionViewCell {
    var data: Game?
    override func awakeFromNib() {
        super.awakeFromNib()
        gamesImage.setGradientBackground(colorTop: .clear, colorBottom: .black.withAlphaComponent(0.2), colorMid: .clear)
    }
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var gamesImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    func setupUI() {
        if let data = data {
            ratingLabel.text = String(data.rating ?? 0)
            gamesImage.sd_setImage(with: URL(string: data.backgroundImage ?? ""))
            gameName.text = data.name
            releaseDateLabel.text = data.released
        }
    }
}
