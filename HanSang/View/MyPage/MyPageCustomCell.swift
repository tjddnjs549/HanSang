//
//  MyPageCustomCell.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import SnapKit
import UIKit

class MyPageCustomCell: UICollectionViewCell {
    static let identifier = "myPageCustomCell"
    private var isBookmarked = false
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.height.equalTo(118)
        }
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "요리명"
        label.textAlignment = .left
        label.font = FontGuide.size14Bold
        label.textColor = ColorGuide.black
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    lazy var bookMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookMark")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorGuide.inputLine
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bookMarkTapped)))
        imageView.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
        return imageView
    }()
    
    private let time: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timer")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorGuide.textHint
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        return imageView
    }()
    
    let timer: UILabel = {
        let label = UILabel()
        label.text = "1시간"
        label.textAlignment = .left
        label.font = FontGuide.size14
        label.textColor = ColorGuide.textHint
        label.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        return label
    }()
    
    private lazy var timerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [time, timer])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    public func configure(_ image: UIImage, _ titleText: String, _ timerText: String) {
        picture.image = image
        title.text = titleText
        timer.text = timerText
        setupUI()
    }
    
    @objc func bookMarkTapped() {
        isBookmarked.toggle()
        configureBookmarkImage()
            
        if let collectionView = self.superview as? UICollectionView {
            collectionView.reloadData()
        }
    }
    
    private func configureBookmarkImage() {
        if isBookmarked {
            self.bookMark.image = UIImage(named: "bookMark.fill")
        } else {
            self.bookMark.image = UIImage(named: "bookMark")
        }
    }
}

extension MyPageCustomCell {
    func setupUI() {
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(picture)
        picture.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(118)
        }
        
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(picture.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
        }
        
        view.addSubview(bookMark)
        bookMark.snp.makeConstraints { make in
            make.top.equalTo(title.snp.top).offset(5)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        view.addSubview(timerStackView)
        timerStackView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(12)
        }
    }
}
