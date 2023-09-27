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
        backButton.tintColor = .systemGray
        backButton.setImage(UIImage(named: "like_icon"), for: .normal)
        return backButton
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        for _ in 0...25 {
            images.append(UIImage(named: "food1")!)
            images.append(UIImage(named: "food2")!)
            images.append(UIImage(named: "food3")!)
            images.append(UIImage(named: "food4")!)
            images.append(UIImage(named: "food5")!)
            images.append(UIImage(named: "food6")!)
            images.append(UIImage(named: "food7")!)
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
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 15),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
        ])
    }
    
//    func contentView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 162.63, height: 163)
//    }
}



extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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

extension  MainViewController: UICollectionViewDelegateFlowLayout {
    
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
