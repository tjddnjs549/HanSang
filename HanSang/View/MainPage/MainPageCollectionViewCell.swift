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
        mpIv.clipsToBounds = true
//        mpIv.layer.cornerRadius = 20
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
        mpTimeLabel.textColor = ColorGuide.textHint
        mpTimeLabel.font = UIFont.systemFont(ofSize: 14)
        return mpTimeLabel
    }()
        
    private let mpLikeButton: UIButton = {
        let mpLikeButton = UIButton()
        mpLikeButton.tintColor = .systemGray
        let heartImage = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20))
        mpLikeButton.setImage(heartImage, for: .normal)
        mpLikeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return mpLikeButton
    }()
    
    private let time: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timer")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorGuide.textHint
        return imageView
    }()


    @objc private func likeButtonTapped() {
        // 좋아요 버튼이 탭되었을 때 수행할 동작을 여기에 추가하세요.
    }
    
    
    public func configure(with image: UIImage) {
        self.myMainPageImageView.image = image
        self.setupUI()
    }
        
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
        self.addSubview(time)
        time.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myMainPageImageView.topAnchor.constraint(equalTo: self.topAnchor),
            myMainPageImageView.widthAnchor.constraint(equalToConstant: 306),
            myMainPageImageView.heightAnchor.constraint(equalToConstant: 230),
            myMainPageImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myMainPageImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            mpLabel.topAnchor.constraint(equalTo: myMainPageImageView.bottomAnchor, constant: 10),
            mpLabel.widthAnchor.constraint(equalToConstant: 150),
            mpLabel.heightAnchor.constraint(equalToConstant: 23),
            mpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            mpTimeLabel.topAnchor.constraint(equalTo: mpLabel.bottomAnchor, constant: 5),
            mpTimeLabel.widthAnchor.constraint(equalToConstant: 50),
            mpTimeLabel.heightAnchor.constraint(equalToConstant: 14),
            mpTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 33),
            
            mpLikeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            mpLikeButton.widthAnchor.constraint(equalToConstant: 30),
            mpLikeButton.heightAnchor.constraint(equalToConstant: 30),
            mpLikeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 230),
            
            time.topAnchor.constraint(equalTo: mpLabel.bottomAnchor, constant: 6),
            time.widthAnchor.constraint(equalToConstant: 12),
            time.heightAnchor.constraint(equalToConstant: 12),
            time.trailingAnchor.constraint(equalTo: mpTimeLabel.leadingAnchor, constant: -8),

        ])
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        self.myMainPageImageView.image = nil
    }
}
