//
//  Extension+UIButton.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/26.
//

import UIKit

extension UIButton {
    
    func buttonMakeUI(backgroundColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor, setTitle: String, font: UIFont, setTitleColor:  UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true //둥글게
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(setTitleColor, for: .normal)
        self.titleLabel?.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buttonImageMakeUI(image: String, selectedImage: String, color: UIColor) {
        self.setImage(UIImage(systemName: image)?.resized(to: CGSize(width: 32, height: 32)).withRenderingMode(.alwaysTemplate), for: .normal) //선택 x
        self.setImage(UIImage(systemName: selectedImage)?.resized(to: CGSize(width: 32, height: 32)).withRenderingMode(.alwaysTemplate), for: .selected) // 선택 o
        self.tintColor = color // 아이콘 색상
        self.isEnabled = true
        self.isSelected = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
