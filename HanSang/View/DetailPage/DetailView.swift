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
        scroll.backgroundColor = .brown
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
        
    }
    
    
    //scrollView
    func scrollViewMakeUI() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        //스크롤뷰 제약
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo:  self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            foodImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
            foodImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
}
