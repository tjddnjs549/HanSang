//
//  MainViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

class MainViewController: UIViewController {

    
    // MARK: - varibles
    private var images: [UIImage] = []
//    let searchController = UISearchController()
    
    private let mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.text = "추천 레시피"
        mainLabel.textAlignment = .left
        mainLabel.textColor = .black
        mainLabel.font = UIFont.systemFont(ofSize: 16)
        return mainLabel
    }()
    
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "카테고리"
        categoryLabel.textAlignment = .left
        categoryLabel.textColor = .black
        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        return categoryLabel
    }()
    
    private let logoLabel: UILabel = {
        let logoLabel = UILabel()
        logoLabel.text = "Logo"
        logoLabel.tintColor = .systemGreen
        // 아이콘 이미지 설정 및 크기 조정
        let logoImage = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
        return logoLabel
    }()
    
    private let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.tintColor = .black
        // 아이콘 이미지 설정 및 크기 조정
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        // 버튼 탭 액션 설정
        
        return searchButton
    }()

    private let bobButton: UIButton = {
        let bobButton = UIButton()
        bobButton.backgroundColor = .white
        bobButton.layer.cornerRadius = 10
        bobButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
        bobButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
        bobButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
        bobButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
        return bobButton
    }()
    
    private let noodleButton: UIButton = {
        let noodleButton = UIButton()
        noodleButton.backgroundColor = .white
        noodleButton.layer.cornerRadius = 10
        noodleButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
        noodleButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
        noodleButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
        noodleButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정

        return noodleButton
    }()
    
    private let breadButton: UIButton = {
        let breadButton = UIButton()
        breadButton.backgroundColor = .white
        breadButton.layer.cornerRadius = 10
        breadButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
        breadButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
        breadButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
        breadButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정

        return breadButton
    }()
    
    private let alcoholButton: UIButton = {
        let alcoholButton = UIButton()
        alcoholButton.backgroundColor = .white
        alcoholButton.layer.cornerRadius = 10
        alcoholButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
        alcoholButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
        alcoholButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
        alcoholButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정

        return alcoholButton
    }()
    
    private let othersButton: UIButton = {
        let othersButton = UIButton()
        othersButton.backgroundColor = .white
        othersButton.layer.cornerRadius = 10
        othersButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
        othersButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
        othersButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
        othersButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정

        return othersButton
    }()
    

    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
//        let button: UIButton = {
//            let button = UIButton()
//            button.setTitle("VC 이동", for: .normal)
//            button.tintColor = .systemGray3
//            button.backgroundColor = .white
//            return button
//        }()
        
        for _ in 0...25 {
            images.append(UIImage(named: "1")!)
            images.append(UIImage(named: "2")!)
            images.append(UIImage(named: "3")!)
            images.append(UIImage(named: "4")!)
            images.append(UIImage(named: "5")!)
            images.append(UIImage(named: "6")!)
            images.append(UIImage(named: "7")!)
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bobButton)
        bobButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(noodleButton)
        noodleButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(breadButton)
        breadButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(alcoholButton)
        alcoholButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(othersButton)
        othersButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(backButton)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 150),
//            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            collectionView.widthAnchor.constraint(equalToConstant: 348),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -15),
            
            mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 120),
            mainLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            
            categoryLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 485),
            categoryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            
            logoLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 65),
            logoLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            
            searchButton.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 65),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -19),
            
            bobButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530),
            bobButton.widthAnchor.constraint(equalToConstant: 90),
            bobButton.heightAnchor.constraint(equalToConstant: 100),
            bobButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            
            noodleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530),
            noodleButton.widthAnchor.constraint(equalToConstant: 90),
            noodleButton.heightAnchor.constraint(equalToConstant: 100),
            noodleButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
            
            breadButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530),
            breadButton.widthAnchor.constraint(equalToConstant: 90),
            breadButton.heightAnchor.constraint(equalToConstant: 100),
            breadButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 260),

            alcoholButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650),
            alcoholButton.widthAnchor.constraint(equalToConstant: 90),
            alcoholButton.heightAnchor.constraint(equalToConstant: 100),
            alcoholButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100),

            othersButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650),
            othersButton.widthAnchor.constraint(equalToConstant: 90),
            othersButton.heightAnchor.constraint(equalToConstant: 100),
            othersButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 210),

        ])
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as?
                MainPageCollectionViewCell else {
            fatalError("Failed to dequeue MainPageCollectionViewCell in MainViewController")
        }
        
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        
        return cell
    }
}

extension  MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.view.frame.width)
        let size = (self.view.frame.width)
        return CGSize(width: 330, height: 300)
    }
    
    // Vertical Specing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
//    // Horizontal Specing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        8
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 200, height: 77)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: 200, height: 200)
//    }
}

