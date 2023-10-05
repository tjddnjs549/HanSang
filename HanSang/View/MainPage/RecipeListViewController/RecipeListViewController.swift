//
//  RecipeListViewController.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/04.
//

import UIKit

class RecipeListViewController: UIViewController {
    var pageTitle: String = ""
    private let recipeListView = RecipeListView()
    let images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension RecipeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else {
            fatalError()
        }
        let image = images[indexPath.row]
        cell.configure(image)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = ColorGuide.textHint.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 12
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
