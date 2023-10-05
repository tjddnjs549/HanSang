//
//  DetailViewTop.swift
//  HanSang
//
//  Created by 박성원 on 2023/10/01.
//

import UIKit

final class DetailViewTop: UIView {

    // MARK: - properties
    lazy var foodImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Food1")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()        
        title.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size24)
        title.text = "집에서도 미디움레어가 가능한 스테이크 레시피"
        return title
    }()
    
    private lazy var timeLabel: UILabel = {
        let time = UILabel()
        time.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16Bold)
        time.text = "시간:"
        return time
    }()
    
    lazy var makeTimeLabel: UILabel = {
        let time = UILabel()
        time.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16)
        time.text = "1시간30분"
        return time
    }()
    
    private lazy var difficultyLabel: UILabel = {
        let difficulty = UILabel()
        difficulty.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16Bold)
        difficulty.text = "난이도:"
        return difficulty
    }()
    
    lazy var makeDifficultyLabel: UILabel = {
        let difficulty = UILabel()
        difficulty.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16)
        difficulty.text = "초보"
        return difficulty
    }()
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profileImage")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16Bold)
        label.text = "닉네임입니다!"
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let like = UIButton(type: .custom)
        like.buttonImageMakeUI(image: "heart", selectedImage: "heart.fill", color: ColorGuide.main)
        return like
    }()

    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = ColorGuide.inputLine
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        TopViewMakeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
    }
}

private extension DetailViewTop {
    
    func TopViewMakeUI() {
        let subView = [foodImageView, titleLabel, timeLabel, makeTimeLabel, difficultyLabel, makeDifficultyLabel, profileImageView, profileNameLabel, likeButton, divider]
        for view in subView {
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
        foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        foodImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        foodImageView.heightAnchor.constraint(equalToConstant: 330),
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  20),
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        titleLabel.topAnchor.constraint(equalTo: self.foodImageView.bottomAnchor, constant: 15),
        
        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        timeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
        timeLabel.trailingAnchor.constraint(equalTo: self.makeTimeLabel.leadingAnchor, constant: -5),
        
        makeTimeLabel.topAnchor.constraint(equalTo: self.timeLabel.topAnchor),
        makeTimeLabel.trailingAnchor.constraint(equalTo: self.difficultyLabel.leadingAnchor, constant: -20),
        
        difficultyLabel.topAnchor.constraint(equalTo: self.timeLabel.topAnchor),
        difficultyLabel.trailingAnchor.constraint(equalTo: self.makeDifficultyLabel.leadingAnchor, constant:  -5),
        
        makeDifficultyLabel.topAnchor.constraint(equalTo: self.timeLabel.topAnchor),
        makeDifficultyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        
        profileImageView.widthAnchor.constraint(equalToConstant: 50),
        profileImageView.heightAnchor.constraint(equalToConstant: 50),
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        profileImageView.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 15),
        profileImageView.trailingAnchor.constraint(equalTo: self.profileNameLabel.leadingAnchor, constant: -10),
        
        profileNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
        profileNameLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor),
        
        likeButton.widthAnchor.constraint(equalToConstant: 32),
        likeButton.heightAnchor.constraint(equalToConstant: 28),
        likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        likeButton.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor),
        
        divider.heightAnchor.constraint(equalToConstant: 2),
        divider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
        divider.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 15),
        divider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
