//
//  DifficultyCollectionViewCell.swift
//  HanSang
//
//  Created by 배은서 on 2023/09/26.
//

import UIKit
import SnapKit

class RecipeInfoItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "RecipeInfoItemCollectionViewCell"
    
    private var isButtonSelected = false
    
    private let button: UIButton = {
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.numberOfLines = 2
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(touchUpButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - @objc
    
    @objc func touchUpButton() {
        button.layer.borderColor = isButtonSelected ? UIColor.black.cgColor : UIColor.systemGray5.cgColor
        isButtonSelected.toggle()
    }
    
    // MARK: - Custom Method
    
    func setup(title: String) {
        button.setTitle(title, for: .normal)
    }
}
