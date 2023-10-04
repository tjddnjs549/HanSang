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
    
    private let bookMarkButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        let heartImage = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20))
        button.setImage(heartImage, for: .normal)
        button.addTarget(self, action: #selector(bookMarkButtonTapped), for: .touchUpInside)
        return button
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
    
    @objc private func bookMarkButtonTapped() {
        // 좋아요 버튼이 탭되었을 때 수행할 동작을 여기에 추가하세요.
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
        
        view.addSubview(bookMarkButton)
        bookMarkButton.snp.makeConstraints { make in
            make.top.equalTo(title.snp.top).offset(5)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        view.addSubview(timerStackView)
        timerStackView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(15)
        }
    }
}
