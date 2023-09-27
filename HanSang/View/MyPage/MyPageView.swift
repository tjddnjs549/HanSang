//
//  MyPageView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import SnapKit
import UIKit

class MyPageView: UIView {
    
    private let userInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
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
        imageView.backgroundColor = .black
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .black
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
        collectionView.register(MyPageCustomCell.self, forCellWithReuseIdentifier: MyPageCustomCell.identifier)
        return collectionView
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
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
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.addSubview(userInfoView)
        userInfoView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }

        userInfoView.addSubview(userInfoStackView)
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }

        scrollView.addSubview(userControlsStackView)
        userControlsStackView.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }

        scrollView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(userControlsStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
