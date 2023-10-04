//
//  RecipeInfoView.swift
//  HanSang
//
//  Created by 배은서 on 2023/09/27.
//

import UIKit
import SnapKit

class RecipeInfoView: UIView {
    
    // MARK: - Properties
    
    private let categoryList = ["🍚 \n밥", "🥘 \n찌개", "🍝 \n면", "🍩 \n베이킹", "🍷 \n술", "🍕 \n분식","🍲 \n찜", "🍴 \n기타"]
    private let difficultyList = ["왕초보", "초보", "중수", "고수"]

    private let recipeLabel: UILabel = {
        $0.text =
                """
                어떤 레시피를
                작성하시겠습니까?
                """
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    lazy var imageView: UIImageView = {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    lazy var imageAddButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("사진을 추가해주세요.")
        titleAttr.font = .systemFont(ofSize: 10, weight: .light)
        config.attributedTitle = titleAttr
        config.image = UIImage(systemName: "photo")
        config.imagePlacement = NSDirectionalRectEdge.top
        config.imagePadding = 15
        $0.configuration = config
        $0.tintColor = .systemGray4
        return $0
    }(UIButton())
    
    lazy var recipeTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.placeholder = "레시피 이름을 입력해주세요."
        return $0
    }(UITextField())
    
    private let categoryLabel: UILabel = {
        $0.text = "카테고리를 선택해주세요."
        return $0
    }(UILabel())
    
    
    private lazy var categoryCollcetionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let categoryHorizontal = UICollectionViewFlowLayout()
        categoryHorizontal.scrollDirection = .horizontal
        collection.collectionViewLayout = categoryHorizontal
        return collection
    }()
    
    private let timeLabel: UILabel = {
        $0.text = "얼마나 걸리나요?"
        return $0
    }(UILabel())
    
    lazy var timeTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.placeholder = "소요시간을 입력해주세요."
        return $0
    }(UITextField())
    
    private let difficultyLabel: UILabel = {
        $0.text = "난이도를 선택해주세요."
        return $0
    }(UILabel())
    
    private let difficultyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        [recipeLabel, categoryLabel, timeLabel, difficultyLabel].forEach {
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 20)
        }
     
        [categoryCollcetionView, difficultyCollectionView].forEach {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
            $0.register(RecipeInfoItemCollectionViewCell.self, forCellWithReuseIdentifier: RecipeInfoItemCollectionViewCell.identifier)
        }
    }
    
    private func setupLayout() {
        [recipeLabel, imageView, imageAddButton, recipeTextField,
         categoryLabel, categoryCollcetionView,
         timeLabel, timeTextField,
         difficultyLabel, difficultyCollectionView].forEach {
            addSubview($0)
        }
        
        recipeLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(15)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(recipeLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(130)
            $0.height.equalTo(100)
        }
        
        imageAddButton.snp.makeConstraints {
            $0.center.equalTo(imageView)
        }
        
        recipeTextField.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(40)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(recipeTextField.snp.bottom).offset(35)
            $0.leading.equalToSuperview().inset(15)
        }
        
        categoryCollcetionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(60)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(categoryCollcetionView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().inset(15)
        }
        
        timeTextField.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(40)
        }
        
        difficultyLabel.snp.makeConstraints {
            $0.top.equalTo(timeTextField.snp.bottom).offset(35)
            $0.leading.equalToSuperview().inset(15)
        }
        
        difficultyCollectionView.snp.makeConstraints {
            $0.top.equalTo(difficultyLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    // MARK: - Custom Method
}

//MARK: - UICollectionViewDataSource

extension RecipeInfoView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollcetionView {
            return categoryList.count
        } else {
            return difficultyList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeInfoItemCollectionViewCell.identifier, for: indexPath) as? RecipeInfoItemCollectionViewCell
        else { return UICollectionViewCell() }
        
        if collectionView == categoryCollcetionView {
            cell.setup(title: categoryList[indexPath.row])
        } else {
            cell.setup(title: difficultyList[indexPath.row])
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension RecipeInfoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollcetionView {
            return CGSize(width: 60, height: 60)
        } else {
            return CGSize(width: 80, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
