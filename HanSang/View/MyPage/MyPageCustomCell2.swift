//
//  MyPageCustomCell2.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import UIKit

class MyPageCustomCell2: UICollectionViewCell {
    static let identifier = "myPageCustomCell2"
    
    var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.8
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "요리 이름"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = ColorGuide.yellow900
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    public func configure(_ image: UIImage) {
        picture.image = image
        setupUI()
    }
}

extension MyPageCustomCell2 {
    func setupUI() {
        addSubview(picture)
        picture.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(picture.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(330)
            make.height.equalTo(50)
        }
        
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
