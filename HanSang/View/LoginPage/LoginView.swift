//
//  LoginView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import UIKit

class LoginView: UIView {
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HANSANG")
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.equalTo(105.37)
            make.height.equalTo(12.54)
        }
        return imageView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.font = FontGuide.size32Bold
        label.textColor = ColorGuide.black
        return label
    }()
    
    private let simbolLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.equalTo(221)
            make.height.equalTo(176)
        }
        return imageView
    }()
    
    let id: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해주세요", attributes: [.font: FontGuide.size16])
        textField.textColor = ColorGuide.textHint
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = ColorGuide.inputLine.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.snp.makeConstraints { make in
            make.width.equalTo(333)
            make.height.equalTo(56)
        }
        return textField
    }()
    
    let pw: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요", attributes: [.font: FontGuide.size16])
        textField.textColor = ColorGuide.textHint
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = ColorGuide.inputLine.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.textContentType = .none
        textField.snp.makeConstraints { make in
            make.width.equalTo(333)
            make.height.equalTo(56)
        }
        return textField
    }()
    
    let pwCheckedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eyes"), for: .normal)
        button.tintColor = .systemGray3
        button.backgroundColor = .white
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = FontGuide.size19Bold
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorGuide.main
        button.layer.cornerRadius = 4
        button.snp.makeConstraints { make in
            make.width.equalTo(333)
            make.height.equalTo(56)
        }
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        let attributedText = NSAttributedString(string: "회원가입", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.font = FontGuide.size16
        button.setTitleColor(ColorGuide.black, for: .normal)
        button.backgroundColor = .white
        button.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(24)
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
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(logo)
        logo.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(22.73)
        }
        
        addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(43.83)
            make.leading.equalTo(30)
        }
        
        addSubview(simbolLogo)
        simbolLogo.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(79)
            make.centerX.equalToSuperview()
        }
        
        addSubview(id)
        id.snp.makeConstraints { make in
            make.top.equalTo(simbolLogo.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
        
        addSubview(pw)
        pw.snp.makeConstraints { make in
            make.top.equalTo(id.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(pwCheckedButton)
        pwCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(pw.snp.centerY)
            make.trailing.equalTo(pw.snp.trailing).offset(-10)
            make.width.height.equalTo(20)
        }
        
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pw.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
}
