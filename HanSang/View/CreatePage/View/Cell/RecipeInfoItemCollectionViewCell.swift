//
//  RecipeInfoItemCollectionViewCell.swift
//  HanSang
//
//  Created by 배은서 on 2023/09/27.
//

import UIKit
import SnapKit

class RecipeInfoItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "RecipeInfoItemCollectionViewCell"
    
    var isButtonSelected = false
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.categoryLabel.layer.borderColor = ColorGuide.black.cgColor
                self.categoryLabel.layer.borderWidth = 1.5
            } else {
                self.categoryLabel.layer.borderColor = ColorGuide.inputLine.cgColor
                self.categoryLabel.layer.borderWidth = 1.5
            }
        }
    }
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size14)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isUserInteractionEnabled = false
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .clear
        self.categoryLabel.layer.borderColor = ColorGuide.inputLine.cgColor
        self.categoryLabel.layer.borderWidth = 1.5
        self.categoryLabel.layer.cornerRadius = 20
    }
    
    private func setupLayout() {
        self.contentView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - @objc


    
    // MARK: - Custom Method
    

}

