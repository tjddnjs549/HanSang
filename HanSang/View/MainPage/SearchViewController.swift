//
//  SearchViewController.swift
//  HanSang
//
//  Created by clone1 on 2023/10/02.
//

import UIKit

class SearchViewController: UIViewController {
//, UISearchResultsUpdating {

    // MARK: - varibles
    private var images: [UIImage] = []
//    let searchController = UISearchController()
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CostomCollectionViewCell.self, forCellWithReuseIdentifier: CostomCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.tintColor = .black
        // 아이콘 이미지 설정 및 크기 조정
        let searchImage = UIImage(systemName: "chevron.left")
        backButton.setImage(searchImage, for: .normal)
        // 버튼 탭 액션 설정
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        return backButton
    }()
    
//    private let backButton: UIButton = {
//        let backButton = UIButton()
//        backButton.tintColor = .systemGray
//        backButton.setImage(UIImage(named: "like_icon"), for: .normal)
//        return backButton
//    }()
    //모다말고 네이게이션뷰컨
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.navigationController?.isNavigationBarHidden = true
//        title = "Search"
//        searchController.searchResultsUpdater = self
//        navigationItem.searchController = searchController
        
//        func updateSearchResults(for searchController: UISearchController) {
//            guard let text = searchController.searchBar.text else {
//                return
//            }
//        }
        
        
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
        self.view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false

//        self.view.addSubview(backButton)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 65),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),

//            backButton.topAnchor.constraint(equalTo: self.view.topAnchor),
//            backButton.widthAnchor.constraint(equalToConstant: 15),
//            backButton.heightAnchor.constraint(equalToConstant: 15),
//            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
        ])
    }
    
//    func contentView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 162.63, height: 163)
//    }
    
    
    // 로그아웃 별도 페이지로 이동 예정(-> 설정 페이지 추가)
    @objc func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
//        UserDefaults.standard.set(false, forKey: "isLoggedIn")
//
//        // 로그인 화면으로 이동
//        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//            let mainViewController = MainViewController()
//            let navigationController = UINavigationController(rootViewController: mainViewController)
//            sceneDelegate.window?.rootViewController = navigationController
//        }
    }
}



extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CostomCollectionViewCell.identifier, for: indexPath) as?
                CostomCollectionViewCell else {
            fatalError("Failed to dequeue CostomCollectionViewCell in MainViewController")
        }
        
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        
        return cell
    }
}

extension  SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.view.frame.width)
        let size = (self.view.frame.width-60)/2
        return CGSize(width: size, height: size)
    }
    
    // Vertical Specing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
//    // Horizontal Specing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        8
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 77)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
