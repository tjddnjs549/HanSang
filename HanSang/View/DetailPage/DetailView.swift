//
//  DetailView.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/26.
//

import UIKit

final class DetailView: UIView {


    
    var isLiked: Bool = false
    // MARK: - properties

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        scroll.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Food1")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 24))
        title.text = "집에서도 미디움레어가 가능한 스테이크 레시피"
        return title
    }()
    
    private lazy var timeLabel: UILabel = {
        let time = UILabel()
        time.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 16))
        time.text = "시간:"
        return time
    }()
    
    private lazy var makeTimeLabel: UILabel = {
        let time = UILabel()
        time.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        time.text = "1시간30분"
        return time
    }()
    
    private lazy var difficultyLabel: UILabel = {
        let difficulty = UILabel()
        difficulty.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 16))
        difficulty.text = "난이도:"
        return difficulty
    }()
    
    private lazy var makeDifficultyLabel: UILabel = {
        let difficulty = UILabel()
        difficulty.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        difficulty.text = "초보"
        return difficulty
    }()
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profileImage")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 16))
        label.text = "닉네임입니다!"
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let like = UIButton(type: .custom)
        like.buttonImageMakeUI(image: "heart", selectedImage: "heart.fill", color: .red)
        like.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return like
    }()

    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    private let materialLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 20))
        label.text = "레시피 재료"
        return label
    }()
    
    lazy var materialTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let recipeLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 20))
        label.text = "조리 방법"
        return label
    }()
    
    private lazy var kickView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var kickLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 18))
        label.text = "레시피 Kick!"
        return label
    }()
    
    lazy var makeKickLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        label.text = """
                    이 레시피의 킥은 이것입니다!
                    이것을 조리할 때 빼먹지말고 넣어주세요.
                    만약 없다면 oo 이것으로 대체해도 무방합니다!
                    """
        return label
    }()
    
    lazy var recipeTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var recipeUdateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.buttonMakeUI(backgroundColor: UIColor.lightGray.withAlphaComponent(0.4), cornerRadius: 10.0, borderWidth: 0.0, borderColor: UIColor.clear.cgColor, setTitle: "레시피 수정하기", font: .boldSystemFont(ofSize: 20), setTitleColor: UIColor.black)
        return button
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //scrollView.contentSize = CGSize(width: bounds.width, height: recipeUdateButton.frame.maxY + 20)
        print(materialTableView.frame)
        print(recipeTableView.frame)
        
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
    }
}

// MARK: - makeUI

private extension DetailView {
    
    func configureUI() {
        scrollViewMakeUI()
        labelMakeUI()
        userInfoMakeUI()
        materialMakeUI()
        kickMakeUI()
    }
    
    
    //scrollView
    func scrollViewMakeUI() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(foodImageView)
        self.contentView.addSubview(titleLabel)
        //스크롤뷰 제약
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo:  self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            foodImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 330),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: self.foodImageView.bottomAnchor, constant: 15)
        ])
    }
    //시간. 난이도 레이아웃
    func labelMakeUI() {
        
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(makeTimeLabel)
        self.contentView.addSubview(difficultyLabel)
        self.contentView.addSubview(makeDifficultyLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(equalTo: self.makeTimeLabel.leadingAnchor, constant: -5),
            
            makeTimeLabel.topAnchor.constraint(equalTo: self.timeLabel.topAnchor),
            makeTimeLabel.trailingAnchor.constraint(equalTo: self.difficultyLabel.leadingAnchor, constant: -20),
            
            difficultyLabel.topAnchor.constraint(equalTo: self.timeLabel.topAnchor),
            difficultyLabel.trailingAnchor.constraint(equalTo: self.makeDifficultyLabel.leadingAnchor, constant:  -5),
            
            makeDifficultyLabel.topAnchor.constraint(equalTo: self.timeLabel.topAnchor),
            makeDifficultyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    //유저 정보 레이아웃
    func userInfoMakeUI() {
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(profileNameLabel)
        self.contentView.addSubview(likeButton)
        self.contentView.addSubview(divider)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profileImageView.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 15),
            profileImageView.trailingAnchor.constraint(equalTo: self.profileNameLabel.leadingAnchor, constant: -10),
            
            profileNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            profileNameLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor),
            
            likeButton.widthAnchor.constraint(equalToConstant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            likeButton.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor),
            
            divider.heightAnchor.constraint(equalToConstant: 2),
            divider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            divider.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 15)
        ])
    }
    
    //재료 레이아웃
    func materialMakeUI() {
        self.contentView.addSubview(materialLabel)
        self.contentView.addSubview(materialTableView)
        self.contentView.addSubview(recipeLabel)
        
        NSLayoutConstraint.activate([
            materialLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            materialLabel.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: 20),
            
            materialTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            materialTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            materialTableView.topAnchor.constraint(equalTo: self.materialLabel.bottomAnchor, constant: 20),
            materialTableView.heightAnchor.constraint(equalToConstant: 200),
            //❗️❗️❗️
            materialTableView.bottomAnchor.constraint(equalTo: self.recipeLabel.topAnchor, constant: -5),
            
            recipeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            recipeLabel.topAnchor.constraint(equalTo: self.materialTableView.bottomAnchor, constant: 20),
        ])
    }

    //킥에서부터 끝까지 부분
    func kickMakeUI() {
        self.contentView.addSubview(kickView)
        self.contentView.addSubview(kickLabel)
        self.contentView.addSubview(makeKickLabel)
        self.contentView.addSubview(recipeTableView)
        self.contentView.addSubview(recipeUdateButton)
        
        NSLayoutConstraint.activate([
            kickView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            kickView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            kickView.topAnchor.constraint(equalTo: self.recipeLabel.bottomAnchor, constant: 20),
            
            kickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            kickLabel.topAnchor.constraint(equalTo: self.kickView.topAnchor, constant: 15),
            
            makeKickLabel.topAnchor.constraint(equalTo: self.kickLabel.bottomAnchor, constant: 10),
            makeKickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            makeKickLabel.trailingAnchor.constraint(equalTo: self.kickView.trailingAnchor, constant: -20),
            makeKickLabel.bottomAnchor.constraint(equalTo: self.kickView.bottomAnchor, constant: -20),
            
            recipeTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            recipeTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            recipeTableView.widthAnchor.constraint(equalToConstant: 343.0),
            recipeTableView.heightAnchor.constraint(equalToConstant: 300),
            // ❗️❗️❗️❗️❗️❗️❗️
            recipeTableView.topAnchor.constraint(equalTo: self.kickView.bottomAnchor, constant: 20),
            recipeTableView.bottomAnchor.constraint(equalTo: self.recipeUdateButton.topAnchor, constant: -30),
            
            recipeUdateButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            recipeUdateButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            recipeUdateButton.topAnchor.constraint(equalTo: self.recipeTableView.bottomAnchor, constant: 30),
            recipeUdateButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
        ])
    }
    
    
}

// MARK: - @objc func

extension DetailView {
    
    @objc func likeButtonTapped() {
        likeButton.isSelected.toggle()
        isLiked = likeButton.isSelected
        print(likeButton.isSelected)
    }
}



