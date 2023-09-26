//
//  RecipeTableViewCell.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/27.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    lazy var recipeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    
}
