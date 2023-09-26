//
//  DetailView.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/26.
//

import UIKit

final class DetailView: UIView {

    var material: [String] = ["스테이크용 소고기", "아스파라거스", "새송이 버섯", "감자", "소스", "돼지고기", "와인", "야파"]
    var unit: [String] =  ["1개", "2개", "3개", "4개", "5개", "6개", "7개", "8개"]
    
    
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
    
    //❗️❗️❗️❗️❗️❗️❗️
    private lazy var likeButton: UIButton = {
        let like = UIButton(type: .custom)
        like.buttonImageMakeUI(image: "heart", selectedImage: "heart.fill", color: .red)
        like.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return like
    }()
    @objc func likeButtonTapped() {
        likeButton.isSelected.toggle() // 선택 상태를 토글합니다.
        isLiked = likeButton.isSelected // isLiked 값을 업데이트합니다.
        print(likeButton.isSelected)
    }
    
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
    
    lazy var materialTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
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
        
        scrollView.contentSize = CGSize(width: bounds.width, height: kickView.frame.maxY + 100)
        print(materialTableView.frame)
        
        
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
        tableViewSetting()
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
            
            divider.heightAnchor.constraint(equalToConstant: 1.5),
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
            materialTableView.heightAnchor.constraint(equalToConstant: 250),
            //❗️❗️❗️
            //materialTableView.bottomAnchor.constraint(equalTo: self.recipeLabel.topAnchor, constant: -20),
            
            recipeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            recipeLabel.topAnchor.constraint(equalTo: self.materialTableView.bottomAnchor, constant: 20),
        ])
    }

    //킥 부분
    func kickMakeUI() {
        self.contentView.addSubview(kickView)
        self.contentView.addSubview(kickLabel)
        self.contentView.addSubview(makeKickLabel)
        
        
        NSLayoutConstraint.activate([
            kickView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            kickView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            kickView.topAnchor.constraint(equalTo: self.recipeLabel.bottomAnchor, constant: 20),
            
            kickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            kickLabel.topAnchor.constraint(equalTo: self.kickView.topAnchor, constant: 15),
            
            makeKickLabel.topAnchor.constraint(equalTo: self.kickLabel.bottomAnchor, constant: 10),
            makeKickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            makeKickLabel.trailingAnchor.constraint(equalTo: self.kickView.trailingAnchor, constant: -20),
            makeKickLabel.bottomAnchor.constraint(equalTo: self.kickView.bottomAnchor, constant: -20)
            
            
        ])
    }
}

// MARK: - tableView 세팅

private extension DetailView {
    
    func tableViewSetting() {
        materialTableView.delegate = self
        materialTableView.dataSource = self
        materialTableView.register(MaterialTableViewCell.self, forCellReuseIdentifier: "MaterialTableViewCell")
    }
    
}

// MARK: - table UITableViewDelegate / UITableViewDataSource


extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return material.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialTableViewCell", for: indexPath) as! MaterialTableViewCell
        cell.materialLabel.text = material[indexPath.row]
        cell.unitLabel.text = unit[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}


extension DetailView: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 30
        }
}






// MARK: - @objc func

extension DetailView {
    

}

