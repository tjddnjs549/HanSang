//
//  DetailView.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/26.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: - properties

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        scroll.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "food")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 24))
        title.text = "집에서도 미디움레어가 가능한 스테이크 레시피"
        return title
    }()
    
    private lazy var timeLabel: UILabel = {
        let time = UILabel()
        time.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 16))
        time.text = "시간:"
        return time
    }()
    
    lazy var makeTimeLabel: UILabel = {
        let time = UILabel()
        time.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        time.text = "1시간30분"
        return time
    }()
    
    private lazy var difficultyLabel: UILabel = {
        let difficulty = UILabel()
        difficulty.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 16))
        difficulty.text = "난이도:"
        return difficulty
    }()
    
    lazy var makeDifficultyLabel: UILabel = {
        let difficulty = UILabel()
        difficulty.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        difficulty.text = "초보중간"
        return difficulty
    }()
    
    
   
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: - makeUI

private extension DetailView {
    
    func configureUI() {
        scrollViewMakeUI()
        labelMakeUI()
    }
    
    
    //scrollView
    func scrollViewMakeUI() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(foodImageView)
        self.contentView.addSubview(titleLabel)
        //스크롤뷰 제약
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo:  self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            foodImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 330),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  30),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: self.foodImageView.bottomAnchor, constant: 20)
        ])
    }
    
    func labelMakeUI() {
        
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(makeTimeLabel)
        self.contentView.addSubview(difficultyLabel)
        self.contentView.addSubview(makeDifficultyLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            timeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: self.makeTimeLabel.leadingAnchor, constant: -5),
            
            makeTimeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            makeTimeLabel.trailingAnchor.constraint(equalTo: self.difficultyLabel.leadingAnchor, constant: -20),
            
            difficultyLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            difficultyLabel.trailingAnchor.constraint(equalTo: self.makeDifficultyLabel.leadingAnchor, constant:  -5),
            
            makeDifficultyLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            makeDifficultyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        
        ])
    }
    
    
    
}


