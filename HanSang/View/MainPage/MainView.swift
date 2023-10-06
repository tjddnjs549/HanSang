//
//  MainView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/04.
//

import UIKit
import SnapKit

class MainView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의"
        label.font = FontGuide.size32
        label.textColor = ColorGuide.black
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 레시피"
        label.font = FontGuide.size32Bold
        label.textColor = ColorGuide.black
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    private let recipeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "recipe")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let categoryBoldLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 메뉴"
        label.textAlignment = .left
        label.font = FontGuide.size19Bold
        label.textColor = ColorGuide.black
        return label
    }()
            
    private let categoryRegularLabel: UILabel = {
        let label = UILabel()
        label.text = "를 만들어 볼까요?"
        label.textAlignment = .left
        label.font = FontGuide.size19
        label.textColor = ColorGuide.black
        return label
    }()
    
    private lazy var categoryTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoryBoldLabel, categoryRegularLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    let riceButton: UIButton = {
        let button = UIButton()
        button.setTitle("🍚", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let riceLabel: UILabel = {
        let label = UILabel()
        label.text = "밥"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var riceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [riceButton, riceLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    let soupButton: UIButton = {
        let button = UIButton()
        button.setTitle("🥘", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let soupLabel: UILabel = {
        let label = UILabel()
        label.text = "찌개"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var soupStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [soupButton, soupLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    let noodleButton: UIButton = {
        let button = UIButton()
        button.setTitle("🍝", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let noodleLabel: UILabel = {
        let label = UILabel()
        label.text = "면"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var noodleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noodleButton, noodleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    let breadButton: UIButton = {
        let button = UIButton()
        button.setTitle("🍩", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let breadLabel: UILabel = {
        let label = UILabel()
        label.text = "베이킹"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var breadStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [breadButton, breadLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    private lazy var firstCategoryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [riceStackView, soupStackView, noodleStackView, breadStackView])
        stackView.axis = .horizontal
        stackView.spacing = 35
        return stackView
    }()
    
    let alcoholButton: UIButton = {
        let button = UIButton()
        button.setTitle("🍷", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let alcoholLabel: UILabel = {
        let label = UILabel()
        label.text = "술"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var alcoholStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [alcoholButton, alcoholLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    let pizzaButton: UIButton = {
        let button = UIButton()
        button.setTitle("🍕", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let pizzaLabel: UILabel = {
        let label = UILabel()
        label.text = "분식"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var pizzaStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pizzaButton, pizzaLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    let steameddishButton: UIButton = {
        let button = UIButton()
        button.setTitle("🍲", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let steameddishLabel: UILabel = {
        let label = UILabel()
        label.text = "찜"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var steameddishStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [steameddishButton, steameddishLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    let othersButton: UIButton = {
        let button = UIButton()
        button.setTitle("🍴", for: .normal)
        button.titleLabel?.font = FontGuide.size28
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 28
        button.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return button
    }()
    
    private let othersLabel: UILabel = {
        let label = UILabel()
        label.text = "기타"
        label.font = FontGuide.size16
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
        return label
    }()
    
    private lazy var othersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [othersButton, othersLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 14
        return stackView
    }()
    
    private lazy var secondCategoryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [alcoholStackView, pizzaStackView, steameddishStackView, othersStackView])
        stackView.axis = .horizontal
        stackView.spacing = 35
        return stackView
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstCategoryStackView, secondCategoryStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(titleStackView)
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalTo(30)
        }
        
        addSubview(recipeIcon)
        recipeIcon.snp.makeConstraints { make in
            make.centerY.equalTo(titleStackView.snp.centerY)
            make.trailing.equalTo(-16)
            make.width.height.equalTo(64)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(24)
            make.leading.equalTo(30)
            make.trailing.equalToSuperview()
            make.height.equalTo(241.6)
        }
        
        addSubview(categoryTitleStackView)
        categoryTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.leading.equalTo(30)
        }
        
        addSubview(categoryStackView)
        categoryStackView.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleStackView.snp.bottom).offset(24)
            make.leading.equalTo(32)
            make.trailing.equalTo(-32)
        }
    }
}
