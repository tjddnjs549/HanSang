//
//  FontGuide.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/27.
//

import Foundation
import UIKit

enum FontGuide {
    static func customFont(size: CGFloat, lineHeight: CGFloat, isBold: Bool = false) -> UIFont {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        
        var fontAttributes: [UIFontDescriptor.AttributeName: Any] = [
            UIFontDescriptor.AttributeName.size: size,
            UIFontDescriptor.AttributeName.featureSettings: [
                [
                    UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                    UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector,
                ],
            ],
        ]
        
        if isBold {
            fontAttributes[UIFontDescriptor.AttributeName.traits] = [
                UIFontDescriptor.TraitKey.weight: UIFont.Weight.bold
            ]
        }
        
        let customFontDescriptor = fontDescriptor.addingAttributes(fontAttributes)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: customFontDescriptor, size: size),
            .paragraphStyle: paragraphStyle,
        ]
        
        return UIFont(descriptor: customFontDescriptor, size: size)
    }
    
    static let size32 = customFont(size: 32, lineHeight: 40)
    static let size32Bold = customFont(size: 32, lineHeight: 40, isBold: true)
    
    static let size19 = customFont(size: 19, lineHeight: 26)
    static let size19Bold = customFont(size: 19, lineHeight: 26, isBold: true)
    
    static let size16 = customFont(size: 16, lineHeight: 24)
    static let size16Bold = customFont(size: 16, lineHeight: 24, isBold: true)
    
    static let size14 = customFont(size: 14, lineHeight: 20)
    static let size14Bold = customFont(size: 14, lineHeight: 20, isBold: true)
}
