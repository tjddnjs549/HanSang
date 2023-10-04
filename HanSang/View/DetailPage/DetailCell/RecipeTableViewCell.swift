//
//  RecipeTableViewCell.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/27.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    static let identifier = "RecipeTableViewCell"
    
    private lazy var cellIndexLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16Bold)
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
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16)
        return label
    }()
    
    lazy var timerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.buttonImageMakeUI(image: "timer", selectedImage: "timer", color: ColorGuide.inputLine)
        return button
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.inputLine, font: FontGuide.size14)
        label.text = "00:00"
        return label
    }()
    
    private lazy var timerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timerButton,timerLabel])
        stack.spacing = 5
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        cellMakeUI(index: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        cellIndexLabel.text = nil
        recipeImageView.image = nil
        recipeLabel.text = nil
    }
}

// MARK: - cellMakeUI

extension RecipeTableViewCell {
    
    func cellMakeUI(index: Int) {
        self.contentView.addSubview(cellIndexLabel)
        self.contentView.addSubview(recipeImageView)
        self.contentView.addSubview(recipeLabel)
        self.contentView.addSubview(timerStackView)
        
        cellIndexLabel.text = "\(index + 1)"
        
        NSLayoutConstraint.activate([
            cellIndexLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            cellIndexLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            cellIndexLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            cellIndexLabel.widthAnchor.constraint(equalToConstant: 10),
            
            recipeImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            recipeImageView.leadingAnchor.constraint(equalTo: cellIndexLabel.trailingAnchor, constant: 6),
            recipeImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            recipeImageView.heightAnchor.constraint(equalToConstant: 70),
            recipeImageView.widthAnchor.constraint(equalToConstant: 70),
            
            recipeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            recipeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 8),
            recipeLabel.trailingAnchor.constraint(equalTo: timerStackView.leadingAnchor, constant: -8),
            recipeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),

            timerStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            timerStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            timerStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        ])
    }
}
