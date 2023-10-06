//
//  SettingView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/03.
//

import UIKit

class SettingView: UIView {
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = ColorGuide.black
        button.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        return button
    }()
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = FontGuide.size32Bold
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(59)
            make.height.equalTo(40)
        }
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text =
            """
            편리하게
            앱을 관리해보세요.
            """
        label.font = FontGuide.size19
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.snp.makeConstraints { make in
            make.width.equalTo(146)
            make.height.equalTo(52)
        }
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingCustomCell.self, forCellReuseIdentifier: SettingCustomCell.identifier)
        return tableView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        let attributedText = NSAttributedString(string: "회원탈퇴", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.font = FontGuide.size16
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = ColorGuide.inputLine.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingView {
    func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.top)
            make.leading.equalTo(30)
        }
        
        addSubview(settingLabel)
        settingLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(39)
            make.leading.equalTo(30)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(settingLabel.snp.bottom).offset(16)
            make.leading.equalTo(30)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}
