//
//  RecipeListViewController.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/04.
//

import UIKit

class RecipeListViewController: UIViewController {
    private let recipeListView = RecipeListView()
    private let dataManager = ContentDataManager.shared
  
    var pageTitle: String = ""
    
    var categoryContents: [Content] = [] {
        didSet {
            recipeListView.collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadCategoryContentsList()
    }
}

private extension RecipeListViewController {
    func setup() {
        view = recipeListView
        recipeListView.recipeListLabel.text = pageTitle
        recipeListView.collectionView.dataSource = self
        recipeListView.collectionView.delegate = self
    
        navigationController?.isNavigationBarHidden = false
        if let originalImage = UIImage(named: "<") {
            let tintedImage = originalImage.withTintColor(ColorGuide.black)
            let button = UIBarButtonItem(image: tintedImage, style: .plain, target: self, action: #selector(goBack))
            button.tintColor = ColorGuide.black
            navigationItem.leftBarButtonItem = button
        }
    }
    
    func loadCategoryContentsList() {
        categoryContents = ContentDataManager.shared.getCategoryContents(category: pageTitle)?.reversed() ?? []
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension RecipeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryContents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else {
            fatalError()
        }

    
        let content = categoryContents[indexPath.row]
        cell.configure(content)

        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }
}

 extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width - 76)/2
        return CGSize(width: size, height: 182)
   }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 16
     }
}

extension RecipeListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.content = dataManager.selectedCategoryContentList(category: pageTitle)[indexPath.item]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
