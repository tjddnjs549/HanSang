//
//  CostomCollectionViewCell.swift
//  HanSang
//
//  Created by clone1 on 2023/09/25.
//

import UIKit

class CostomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CostomCollectionViewCell"
    
    private let myimageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    public func configure(with image: UIImage) {
        self.myimageView.image = image
        self.setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .systemRed
        
        self.addSubview(myimageView)
        myimageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myimageView.topAnchor.constraint(equalTo: self.topAnchor),
            myimageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            myimageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myimageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        self.myimageView.image = nil
    }
}
