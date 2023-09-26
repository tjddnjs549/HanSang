//
//  SignUpView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button        
    }()

    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = ColorGuide.blue600
        imageView.backgroundColor = ColorGuide.yellow900
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.textColor = .black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디 입력"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabel, idTextField])
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    private let pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let pwTextField: UITextField = {
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
    
    private lazy var pwStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pwLabel, pwTextField])
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    private let verifyPwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.textColor = .black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let verifyPwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 재입력"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.textContentType = .none
        return textField
    }()
    
    private lazy var verifyPwStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verifyPwLabel, verifyPwTextField])
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임 입력"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var nicknameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, nicknameTextField])
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var signUpInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idStackView, pwStackView, verifyPwStackView, nicknameStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정 만들기", for: .normal)
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
}

private extension SignUpView {
    func setupUI() {
        backgroundColor = .systemBackground
        addSubview(cancelButton)
        addSubview(logo)
        addSubview(profilePicture)
        addSubview(signUpInfoStackView)
        addSubview(okButton)
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.equalTo(15)
        }
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(20)
            make.leading.equalTo(100)
        }
        
        profilePicture.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        signUpInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(signUpInfoStackView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
    }
}
