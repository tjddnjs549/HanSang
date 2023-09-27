//
//  MyPageCustomCell.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import UIKit
import SnapKit

class MyPageCustomCell: UICollectionViewCell {
    
    static let identifier = "myPageCustomCell"
    
    var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public func configure(_ image: UIImage) {
        picture.image = image
        setupUI()
    }
    
//    public func configure(_ content: Content) {
//        if let imageData = content.picture,
//           let image = UIImage(data: imageData) {
//            self.picture.image = image
//        } else {
//            print("이미지 로드 오류")
//        }
//        setupUI()
//    }
}

extension MyPageCustomCell {
    func setupUI() {
        addSubview(picture)
        picture.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
