//
//  BookMarkViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

class BookMarkViewController: UIViewController {
    private let bookMarkView = BookMarkView()
    var bookmarkedContents: [Content] = [] {
        didSet {
            bookMarkView.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBookmarkedContents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupBookmarkedContents()
    }
}

private extension BookMarkViewController {
    func setup() {
        view = bookMarkView
        bookMarkView.collectionView.dataSource = self
        bookMarkView.collectionView.delegate = self
    
        if let originalImage = UIImage(named: "HANSANG") {
            let tintedImage = originalImage.withTintColor(ColorGuide.main)
            let button = UIBarButtonItem(image: tintedImage, style: .plain, target: nil, action: nil)
            button.tintColor = ColorGuide.main
            navigationItem.leftBarButtonItem = button
        }
    }
    
    func setupBookmarkedContents() {
        bookmarkedContents = ContentDataManager.shared.getContentBookmark()
    }
}

extension BookMarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarkedContents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else {
            fatalError()
        }
        
        let content = bookmarkedContents[indexPath.row]
        cell.configure(content)
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }
}

 extension BookMarkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width - 76)/2
        return CGSize(width: size, height: 182)
   }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 16
     }
 }
