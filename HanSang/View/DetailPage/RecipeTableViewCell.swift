//
//  RecipeTableViewCell.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/27.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    private lazy var cellIndexLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 16))
        return label
    }()
    
    lazy var recipeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        return label
    }()
    
    lazy var timerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Start Timer", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        cellMakeUI(index: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
    }
}

// MARK: - cellMakeUI

extension RecipeTableViewCell {
    
    func cellMakeUI(index: Int) {
        self.contentView.addSubview(cellIndexLabel)
        self.contentView.addSubview(recipeImageView)
        self.contentView.addSubview(recipeLabel)
        self.contentView.addSubview(timerButton)
        
        cellIndexLabel.text = "\(index + 1)"
        
        NSLayoutConstraint.activate([
            cellIndexLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            cellIndexLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            cellIndexLabel.trailingAnchor.constraint(equalTo: self.recipeImageView.leadingAnchor, constant: -10),
            
            recipeImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 70),
            recipeImageView.heightAnchor.constraint(equalToConstant: 70),
            recipeImageView.trailingAnchor.constraint(equalTo: self.recipeLabel.leadingAnchor, constant: -10),
            
            recipeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            recipeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            timerButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            timerButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])
    }
    
}
