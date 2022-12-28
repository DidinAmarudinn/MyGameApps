//
//  PlatfromCollectionViewCell.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import UIKit
import SDWebImage
class PlatfromCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePlatfrom: UIImageView!
    @IBOutlet weak var platfromNameLabel: UILabel!
    var data: Platfrom?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI() {
        if let data = data {
            imagePlatfrom.sd_setImage(with: URL(string: data.imageBackground ?? ""))
            platfromNameLabel.text = data.name
        }
    }
}
