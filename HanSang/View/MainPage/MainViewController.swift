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
    private var images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension MainViewController {
    func setupUI() {
        view = mainView
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
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
        
        mainView.riceButton.addTarget(self, action: #selector(riceButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @objc func riceButtonTapped() {
        let recipeListVC = RecipeListViewController()
        navigationController?.pushViewController(recipeListVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as?
                MainPageCollectionViewCell else {
            fatalError("Failed to dequeue MainPageCollectionViewCell in MainViewController")
        }
        
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
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
