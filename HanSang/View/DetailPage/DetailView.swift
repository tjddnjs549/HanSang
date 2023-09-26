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
        image.image = UIImage(named: "ProfileImage")
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
        divider.backgroundColor = UIColor.lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    private let materialLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 20))
        label.text = "레시피 재료"
        return label
    }()
    
    private lazy var materialTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.borderWidth = 2.0
        table.layer.borderColor = UIColor.black.cgColor
        return table
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.borderColor = UIColor.black.cgColor
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
            
            divider.heightAnchor.constraint(equalToConstant: 1.5),
            divider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            divider.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 15)
        ])
    }
    
    //레시피 재료 레이아웃
    func materialMakeUI() {
        self.contentView.addSubview(materialLabel)
        self.contentView.addSubview(materialTableView)
        
        NSLayoutConstraint.activate([
            materialLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            materialLabel.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: 20),
            materialLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
        
            materialTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            materialTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            materialTableView.topAnchor.constraint(equalTo: self.materialLabel.bottomAnchor, constant: 20)
        ])
    }
}


// MARK: - table UITableViewDelegate / UITableViewDataSource


extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


extension DetailView: UITableViewDelegate {
    
}






// MARK: - @objc func

extension DetailView {
    
    @objc func likeButtonTapped() {
        isLiked.toggle()
        likeButton.isSelected = isLiked // 버튼의 선택 상태를 업데이트
    }
}

