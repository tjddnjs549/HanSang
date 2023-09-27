//
//  SignUpView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import SnapKit
import UIKit

class SignUpView: UIView {
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultImage")
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
        textField.snp.makeConstraints { make in
            make.width.equalTo(180)
        }
        return textField
    }()
    
    private lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabel, idTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
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
    
    let pwCheckedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eyes"), for: .normal)
        button.tintColor = .systemGray3
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var pwStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pwLabel, pwTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let confirmPwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.textColor = .black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let confirmPwTextField: UITextField = {
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
    
    let confirmPwCheckedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eyes"), for: .normal)
        button.tintColor = .systemGray3
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var confirmPwStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [confirmPwLabel, confirmPwTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
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
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var signUpInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idStackView, pwStackView, confirmPwStackView, nicknameStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정 만들기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignUpView {
    func setupUI() {
        backgroundColor = .systemBackground
        addSubview(cancelButton)
        addSubview(profilePicture)
        addSubview(signUpInfoStackView)
        addSubview(pwCheckedButton)
        addSubview(confirmPwCheckedButton)
        addSubview(createButton)
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.equalTo(15)
        }
        
        profilePicture.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        signUpInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        pwCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(pwTextField.snp.centerY)
            make.trailing.equalTo(pwTextField.snp.trailing).offset(-10)
            make.width.height.equalTo(20)
        }
        // 커밋용
        confirmPwCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(confirmPwTextField.snp.centerY)
            make.trailing.equalTo(confirmPwTextField.snp.trailing).offset(-10)
            make.width.height.equalTo(20)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(signUpInfoStackView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
    }
}
