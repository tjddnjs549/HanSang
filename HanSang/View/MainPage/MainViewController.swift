//
//  MainViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - varibles
    private let mainView = MainView()
    private var content: [Content] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        categoryButtonAction()
    }
}

private extension MainViewController {
    func setupUI() {
        view = mainView
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        content = ContentDataManager.shared.getContentListFromCoreData()
        if let originalImage = UIImage(named: "HANSANG") {
            let tintedImage = originalImage.withTintColor(ColorGuide.main)
            let button = UIBarButtonItem(image: tintedImage, style: .plain, target: nil, action: nil)
            button.tintColor = ColorGuide.main
            navigationItem.leftBarButtonItem = button
        }
        
        if let settingImage = UIImage(named: "search") {
            let originalSize = settingImage.size
            let scaledSize = CGSize(width: originalSize.width * 0.8, height: originalSize.height * 0.8)
            let renderer = UIGraphicsImageRenderer(size: scaledSize)
            let scaledSettingImage = renderer.image { _ in
                settingImage.draw(in: CGRect(origin: .zero, size: scaledSize))
            }
            let coloredSettingImage = scaledSettingImage.withTintColor(ColorGuide.textHint, renderingMode: .alwaysOriginal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: coloredSettingImage, style: .plain, target: self, action: #selector(searchButtonTapped))
        }
    }
    
    func categoryButtonAction() {
        mainView.riceButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        mainView.soupButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        mainView.noodleButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        mainView.breadButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        mainView.alcoholButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        mainView.pizzaButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        mainView.steameddishButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        mainView.othersButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        mainView.riceButton.tag = 1
        mainView.soupButton.tag = 2
        mainView.noodleButton.tag = 3
        mainView.breadButton.tag = 4
        mainView.alcoholButton.tag = 5
        mainView.pizzaButton.tag = 6
        mainView.steameddishButton.tag = 7
        mainView.othersButton.tag = 8
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        var categoryTitle: String = ""

        switch sender.tag {
        case 1:
            categoryTitle = "밥"
        case 2:
            categoryTitle = "찌개"
        case 3:
            categoryTitle = "면"
        case 4:
            categoryTitle = "베이킹"
        case 5:
            categoryTitle = "술"
        case 6:
            categoryTitle = "분식"
        case 7:
            categoryTitle = "찜"
        case 8:
            categoryTitle = "기타"
        default:
            break
        }

        let recipeListVC = RecipeListViewController()
        recipeListVC.pageTitle = categoryTitle
        navigationController?.pushViewController(recipeListVC, animated: true)
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as?
                MainPageCollectionViewCell else {
            fatalError("Failed to dequeue MainPageCollectionViewCell in MainViewController")
        }
        
        let contents = self.content[indexPath.row]
        if let imageData = contents.picture, let image = UIImage(data: imageData) {
            cell.configure(with: image, title: contents.title!, timer: contents.time!)
        }
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.content = content[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension  MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 224, height: 241.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}
