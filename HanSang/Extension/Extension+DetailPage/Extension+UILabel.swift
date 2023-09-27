//
//  Extension+UILabel.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/26.
//

import UIKit

extension UILabel {
    func labelMakeUI(textColor: UIColor, font: UIFont) {
        self.textColor = textColor
        self.font = font
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
