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
//        iv.frame = CGRect(x: 0, y: 0, width: 162.63, height: 121.98)
        iv.clipsToBounds = true
        return iv
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Costom"
        label.textAlignment = .left
        label.textColor = .white
//        label.text = sizeThatFits(30)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "2시간"
        timeLabel.textAlignment = .left
        timeLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        return timeLabel
    }()
    
//    private let likeButton: UIButton = {
//        let likeButton = UIButton()
//
//        return likeButton
//    }()
    
    private let likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.tintColor = .systemGray
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        // 좋아요 아이콘 이미지 설정
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        // 버튼 탭 액션 설정
        return likeButton
    }()

    @objc private func likeButtonTapped() {
        // 좋아요 버튼이 탭되었을 때 수행할 동작을 여기에 추가하세요.
    }
    
    
    public func configure(with image: UIImage) {
        self.myimageView.image = image
//        contentView.addSubview(label)
        self.setupUI()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.frame = CGRect(x: 5, y: myimageView.frame.size.height-50, width: myimageView.frame.size.width-10, height: 50)
////        label.frame = bounds
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // contentView에 라운드 코너 적용
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
//
//    }
    
    private func setupUI() {
        self.backgroundColor = .systemGreen
        
        self.addSubview(myimageView)
        myimageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        

        
        NSLayoutConstraint.activate([
            myimageView.topAnchor.constraint(equalTo: self.topAnchor),
            myimageView.widthAnchor.constraint(equalToConstant: 162.63),
            myimageView.heightAnchor.constraint(equalToConstant: 121.98),
            myimageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myimageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: myimageView.bottomAnchor, constant: 7),
            label.widthAnchor.constraint(equalToConstant: 70),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            timeLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2),
            timeLabel.widthAnchor.constraint(equalToConstant: 50),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
//            likeButton.topAnchor.constraint(equalTo: myimageView.bottomAnchor, constant: 3),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            likeButton.widthAnchor.constraint(equalToConstant: 17),
            likeButton.heightAnchor.constraint(equalToConstant: 15),
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
        ])
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        self.myimageView.image = nil
    }
}

