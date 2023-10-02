//
//  MyPageView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import SnapKit
import UIKit

class MyPageView: UIView {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let userInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let nickname: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textAlignment = .left
        label.font = FontGuide.size32Bold
        label.textColor = ColorGuide.black
        return label
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "님"
        label.textAlignment = .left
        label.font = FontGuide.size32
        label.textColor = ColorGuide.black
        return label
    }()
    
    private let recipe: UILabel = {
        let label = UILabel()
        label.text = "나의 레시피"
        label.textAlignment = .left
        label.font = FontGuide.size14
        label.textColor = ColorGuide.black
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    private lazy var nicknameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nickname, nicknameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    let recipeCount: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.textAlignment = .left
        label.font = FontGuide.size19Bold
        label.textColor = ColorGuide.black
        label.snp.makeConstraints { make in
            make.height.equalTo(26)
        }
        return label
    }()
    
    private lazy var recipeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipe, recipeCount])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameStackView, recipeStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()
    
    let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.backgroundColor = ColorGuide.subButton
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        return imageView
    }()
    
    let edit: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pencil")
        imageView.backgroundColor = ColorGuide.subButton
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = ColorGuide.inputLine.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        return imageView
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackView, profilePicture])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 78
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalTo(30)
        }

        addSubview(profilePicture)
        profilePicture.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.top)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        addSubview(edit)
        edit.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.top).offset(56)
            make.leading.equalTo(profilePicture.snp.leading).offset(59)
        }

        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview()
        }
    }
}
