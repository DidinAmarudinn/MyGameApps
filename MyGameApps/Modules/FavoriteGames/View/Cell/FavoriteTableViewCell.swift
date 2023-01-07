//
//  FavoriteTableViewCell.swift
//  MyGameApps
//
//  Created by didin amarudin on 06/01/23.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var imageGames: UIImageView!
    var onDelete: (()-> Void)?
    var data: GameDataModel?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupUI() {
        if let data {
            releaseDate.text = data.released
            title.text = data.name
            rating.text = String(data.rating ?? 0)
            if let image = data.image {
                imageGames.image = UIImage(data: image)
            }
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        onDelete?()
    }
}
