//
//  DetailView.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/26.
//

import UIKit

final class DetailView: UIView {
    
    lazy var detailViewTop = DetailViewTop()
    lazy var detailViewMiddle = DetailViewMiddle()
    lazy var detailViewBottom = DetailViewBottom()

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
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailView {
    func configureUI() {
        scrollViewMakeUI()
    }
    
    func scrollViewMakeUI() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(detailViewTop)
        self.contentView.addSubview(detailViewMiddle)
        self.contentView.addSubview(detailViewBottom)
        
        detailViewTop.translatesAutoresizingMaskIntoConstraints = false
        detailViewMiddle.translatesAutoresizingMaskIntoConstraints = false
        detailViewBottom.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo:  self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0),
            
            detailViewTop.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            detailViewTop.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            detailViewTop.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            detailViewTop.bottomAnchor.constraint(equalTo: self.detailViewMiddle.topAnchor, constant: 0),
            
            detailViewMiddle.heightAnchor.constraint(equalToConstant: 450),
            detailViewMiddle.topAnchor.constraint(equalTo: self.detailViewTop.bottomAnchor, constant: 0),
            detailViewMiddle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            detailViewMiddle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            
            detailViewBottom.topAnchor.constraint(equalTo: self.detailViewMiddle.bottomAnchor, constant: 0),
            detailViewBottom.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            detailViewBottom.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            detailViewBottom.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
        ])
    }
}
