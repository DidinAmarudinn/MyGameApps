//
//  UIVIew+Gradienr.swift
//  MyGameApps
//
//  Created by didin amarudin on 27/12/22.
//

import Foundation
import UIKit
extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, colorMid: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorMid.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

       layer.insertSublayer(gradientLayer, at: 0)
    }

}
