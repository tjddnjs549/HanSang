//
//  MainPageCollectionViewCell.swift
//  HanSang
//
//  Created by clone1 on 2023/09/28.
//

import UIKit

class MainPageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainPageCollectionViewCell"
    
    private let myMainPageImageView: UIImageView = {
        let mpIv = UIImageView()
        mpIv.contentMode = .scaleAspectFill
        mpIv.image = UIImage(systemName: "questionmark")
        mpIv.tintColor = .white
//        mpIv.layer.cornerRadius = 18
//        iv.frame = CGRect(x: 0, y: 0, width: 162.63, height: 121.98)
        mpIv.clipsToBounds = true
        return mpIv
    }()
    
    private let mpLabel: UILabel = {
        let mpLabel = UILabel()
        mpLabel.text = "Costom"
        mpLabel.textAlignment = .left
        mpLabel.textColor = .black
        mpLabel.font = UIFont.systemFont(ofSize: 22)
        return mpLabel
    }()
    
    private let mpTimeLabel: UILabel = {
        let mpTimeLabel = UILabel()
        mpTimeLabel.text = "2시간"
        mpTimeLabel.textAlignment = .left
        mpTimeLabel.textColor = .black
        mpTimeLabel.font = UIFont.systemFont(ofSize: 14)
        return mpTimeLabel
    }()
    
//    private let likeButton: UIButton = {
//        let likeButton = UIButton()
//
//        return likeButton
//    }()
    
    private let mpLikeButton: UIButton = {
        let mpLikeButton = UIButton()
        mpLikeButton.tintColor = .systemGray
        // 아이콘 이미지 설정 및 크기 조정
        let heartImage = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20))
        mpLikeButton.setImage(heartImage, for: .normal)
        mpLikeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        // 버튼 탭 액션 설정
        return mpLikeButton
    }()

    @objc private func likeButtonTapped() {
        // 좋아요 버튼이 탭되었을 때 수행할 동작을 여기에 추가하세요.
    }
    
    
    public func configure(with image: UIImage) {
        self.myMainPageImageView.image = image
//        contentView.addSubview(label)
        self.setupUI()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.frame = CGRect(x: 5, y: myimageView.frame.size.height-50, width: myimageView.frame.size.width-10, height: 50)
////        label.frame = bounds
//
//
//    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(myMainPageImageView)
        myMainPageImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mpLabel)
        mpLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mpTimeLabel)
        mpTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mpLikeButton)
        mpLikeButton.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            myMainPageImageView.topAnchor.constraint(equalTo: self.topAnchor),
            myMainPageImageView.widthAnchor.constraint(equalToConstant: 306),
            myMainPageImageView.heightAnchor.constraint(equalToConstant: 230),
            myMainPageImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myMainPageImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            mpLabel.topAnchor.constraint(equalTo: myMainPageImageView.bottomAnchor, constant: 15),
            mpLabel.widthAnchor.constraint(equalToConstant: 150),
            mpLabel.heightAnchor.constraint(equalToConstant: 23),
            mpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            mpTimeLabel.topAnchor.constraint(equalTo: mpLabel.bottomAnchor, constant: 5),
            mpTimeLabel.widthAnchor.constraint(equalToConstant: 50),
            mpTimeLabel.heightAnchor.constraint(equalToConstant: 14),
            mpTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
//            likeButton.topAnchor.constraint(equalTo: myimageView.bottomAnchor, constant: 3),
            mpLikeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            mpLikeButton.widthAnchor.constraint(equalToConstant: 35),
            mpLikeButton.heightAnchor.constraint(equalToConstant: 35),
            mpLikeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 278),
            
        ])
        
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        self.myMainPageImageView.image = nil
    }
}
