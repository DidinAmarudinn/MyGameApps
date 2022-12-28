//
//  AboutViewController.swift
//  MyGameApps
//
//  Created by didin amarudin on 28/12/22.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        descriptionLabel.setLineSpacing(lineSpacing: 1.5)
    }
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
