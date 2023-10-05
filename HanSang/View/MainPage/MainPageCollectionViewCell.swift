//
//  MainPageCollectionViewCell.swift
//  HanSang
//
//  Created by clone1 on 2023/09/28.
//

import UIKit
import SnapKit

class MainPageCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainPageCollectionViewCell"
    private var isBookmarked = false
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let picture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "요리명"
        label.textAlignment = .left
        label.font = FontGuide.size19Bold
        label.textColor = ColorGuide.black
        label.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        return label
    }()
    
    private let timer: UILabel = {
        let label = UILabel()
        label.text = "2시간"
        label.textAlignment = .left
        label.font = FontGuide.size16
        label.textColor = ColorGuide.textHint
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
        return imageView
    }()
    
    private let time: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timer")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorGuide.textHint
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        return imageView
    }()
    
    private lazy var timerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [time, timer])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 6
        return stackView
    }()
    
    @objc func bookMarkTapped() {
        if let collectionView = self.superview as? UICollectionView {
            isBookmarked.toggle()
            configureBookmarkImage()
            collectionView.reloadData()
        }
    }
    
    func configureBookmarkImage() {
        if isBookmarked {
            self.bookMark.image = UIImage(named: "bookMark.fill")
        } else {
            self.bookMark.image = UIImage(named: "bookMark")
        }
    }
    
    public func configure(with image: UIImage) {
        picture.image = image
        setupUI()
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        self.picture.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.snp.makeConstraints { make in
            make.height.equalTo(241.6)
        }
    }
}

extension MainPageCollectionViewCell {
    func setupUI() {
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(picture)
        picture.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(picture.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        view.addSubview(bookMark)
        bookMark.snp.makeConstraints { make in
            make.top.equalTo(title.snp.top).offset(5)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(21)
            make.height.equalTo(18.23)
        }
        
        view.addSubview(timerStackView)
        timerStackView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(15)
        }
    }
}
