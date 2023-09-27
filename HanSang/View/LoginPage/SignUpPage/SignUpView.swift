//
//  SignUpView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/27.
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
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultImage")
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        return textField
    }()
    
    let idTextFieldDescription: UILabel = {
        let label = UILabel()
        label.text = "  🚨 필수 입력 사항입니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .red
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    let idCheckedButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabel, idTextField, idTextFieldDescription])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let pwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.textContentType = .none
        textField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        return textField
    }()
    
    let pwTextFieldDescription: UILabel = {
        let label = UILabel()
        label.text = "  🚨 필수 입력 사항입니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .red
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    let pwCheckedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eyes"), for: .normal)
        button.tintColor = .systemGray3
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var pwStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pwLabel, pwTextField, pwTextFieldDescription])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let confirmPwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let confirmPwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 다시 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.textContentType = .none
        textField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        return textField
    }()
    
    let confirmPwTextFieldDescription: UILabel = {
        let label = UILabel()
        label.text = "  🚨 필수 입력 사항입니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .red
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    let confirmPwCheckedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eyes"), for: .normal)
        button.tintColor = .systemGray3
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var confirmPwStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [confirmPwLabel, confirmPwTextField, confirmPwTextFieldDescription])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        return textField
    }()
    
    let nicknameTextFieldDescription: UILabel = {
        let label = UILabel()
        label.text = "  🚨 필수 입력 사항입니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .red
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    let nicknameCheckedButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var nicknameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, nicknameTextField, nicknameTextFieldDescription])
        stackView.axis = .vertical
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray6
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
        addSubview(signUpLabel)
        addSubview(profilePicture)
        addSubview(signUpInfoStackView)
        addSubview(idCheckedButton)
        addSubview(pwCheckedButton)
        addSubview(confirmPwCheckedButton)
        addSubview(nicknameCheckedButton)
        addSubview(createButton)
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.equalTo(15)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(20)
            make.leading.equalTo(15)
        }
        
        profilePicture.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        signUpInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.bottom).offset(20)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
        }
        
        idCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(idTextField.snp.centerY)
            make.trailing.equalTo(idTextField.snp.trailing).offset(-10)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        pwCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(pwTextField.snp.centerY)
            make.trailing.equalTo(pwTextField.snp.trailing).offset(-10)
            make.width.height.equalTo(20)
        }
        
        confirmPwCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(confirmPwTextField.snp.centerY)
            make.trailing.equalTo(confirmPwTextField.snp.trailing).offset(-10)
            make.width.height.equalTo(20)
        }
        
        nicknameCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameTextField.snp.centerY)
            make.trailing.equalTo(nicknameTextField.snp.trailing).offset(-10)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        createButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
    }
}
