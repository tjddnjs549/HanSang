//
//  MyPageView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import UIKit
import SnapKit

class MyPageView2: UIView {

//    var profilePicture: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "profileImage")
//        imageView.backgroundColor = ColorGuide.yellow900
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 44
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    var recipeCount: UILabel = {
//        let label = UILabel()
//        label.text = "7"
//        label.font = UIFont(name: "NotoSansKR-Bold", size: 16.5)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let recipe: UILabel = {
//        let label = UILabel()
//        label.text = "레시피"
//        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
//        label.textAlignment = .center
//        return label
//    }()
//
//    var followerCount: UILabel = {
//        let label = UILabel()
//        label.text = "0"
//        label.font = UIFont(name: "NotoSansKR-Bold", size: 16.5)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let follower: UILabel = {
//        let label = UILabel()
//        label.text = "팔로워"
//        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
//        label.textAlignment = .center
//        return label
//    }()
//
//    var followingCount: UILabel = {
//        let label = UILabel()
//        label.text = "0"
//        label.font = UIFont(name: "NotoSansKR-Bold", size: 16.5)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let following: UILabel = {
//        let label = UILabel()
//        label.text = "팔로잉"
//        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private lazy var recipeStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [recipeCount, recipe])
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 5
//        return stackView
//    }()
//
//    private lazy var followerStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [followerCount, follower])
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 5
//        return stackView
//    }()
//
//    private lazy var followingStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [followingCount, following])
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 5
//        return stackView
//    }()
//
//    private lazy var userFollowInfo: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [recipeStackView, followerStackView, followingStackView])
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
//        return stackView
//    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    private let recipe: UILabel = {
        let label = UILabel()
        label.text = "나의 레시피"
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let recipeCount: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    var profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileImage")
        imageView.backgroundColor = ColorGuide.yellow900
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 44
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(88)
        }
        return imageView
    }()
    
    private lazy var recipeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipe, recipeCount])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, recipeStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackView, profilePicture])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let profileEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 5
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var userControlsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileEditButton, logoutButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MyPageCustomCell2.self, forCellWithReuseIdentifier: MyPageCustomCell2.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground

        addSubview(userInfoStackView)
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }

        addSubview(userControlsStackView)
        userControlsStackView.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(userControlsStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
