//
//  UILabel+Ext.swift
//  MyGameApps
//
//  Created by didin amarudin on 28/12/22.
//

import Foundation
import UIKit
extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: self.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
