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
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let id: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디 입력"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let pw: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 입력"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.textContentType = .none
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 10
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 10
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
        addSubview(id)
        addSubview(pw)
        addSubview(loginButton)
        addSubview(signUpButton)
        
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(180)
            make.width.height.equalTo(200)
        }
        
        id.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        pw.snp.makeConstraints { make in
            make.top.equalTo(id.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pw.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
    }
}
