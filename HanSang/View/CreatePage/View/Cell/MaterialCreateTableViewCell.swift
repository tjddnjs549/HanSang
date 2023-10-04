//
//  MaterialCreateTableViewCell.swift
//  HanSang
//
//  Created by 배은서 on 2023/09/28.
//

import UIKit
import SnapKit

class MaterialCreateTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    // MARK: - Properties
    
    static let identifier = "MaterialCreateTableViewCell"
    
    var touchedDeleteButton: (() -> ())?
    
    private let deleteButton: UIButton = {
        $0.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        $0.tintColor = .systemGray4
        $0.addTarget(self, action: #selector(touchUpDeleteButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let materialTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.placeholder = "재료명"
        return $0
    }(UITextField())
    
    private let amountTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.placeholder = "용량"
        return $0
    }(UITextField())
    
    private let materialStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .clear
        
        [materialTextField, amountTextField].forEach {
            materialStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        [deleteButton, materialStackView].forEach {
            contentView.addSubview($0)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(30)
        }
        
        materialStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(deleteButton.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    //MARK: - @objc
    
    @objc private func touchUpDeleteButton() {
        touchedDeleteButton?()
    }
}
