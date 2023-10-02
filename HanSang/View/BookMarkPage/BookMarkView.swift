//
//  BookMarkView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/02.
//

import UIKit

class BookMarkView: UIView {
    
    private let bookMarkLabel: UILabel = {
        let label = UILabel()
        label.text = "찜한 레시피"
        label.font = FontGuide.size32Bold
        label.textColor = ColorGuide.black
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MyPageCustomCell.self, forCellWithReuseIdentifier: MyPageCustomCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(bookMarkLabel)
        bookMarkLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalTo(30)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(30)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-30)
            make.top.equalTo(bookMarkLabel.snp.bottom).offset(30)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
