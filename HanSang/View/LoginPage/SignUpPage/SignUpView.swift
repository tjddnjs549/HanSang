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
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
    
    private let idCheckedLabel: UILabel = {
        let label = UILabel()
        label.text = "사용 가능한 아이디입니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var idLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabel, idCheckedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디 입력"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let idCheckedButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabelStackView, idTextField])
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
    
    private let pwCheckedLabel: UILabel = {
        let label = UILabel()
        label.text = "사용 가능한 비밀번호입니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var pwLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pwLabel, pwCheckedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
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
        let stackView = UIStackView(arrangedSubviews: [pwLabelStackView, pwTextField])
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
    
    private let confirmPwCheckedLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치합니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var confirmLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [confirmPwLabel, confirmPwCheckedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
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
        let stackView = UIStackView(arrangedSubviews: [confirmLabelStackView, confirmPwTextField])
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
    
    private let nicknameCheckedLabel: UILabel = {
        let label = UILabel()
        label.text = "사용 가능한 닉네임입니다."
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var nicknameLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, nicknameCheckedLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임 입력"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let nicknameCheckedButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = ColorGuide.yellow900
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var nicknameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabelStackView, nicknameTextField])
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
            make.top.equalTo(signUpLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(140)
        }
        
        signUpInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.bottom).offset(30)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
        }
        
        idCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(idTextField.snp.centerY)
            make.trailing.equalTo(idTextField.snp.trailing).offset(-10)
            make.width.equalTo(70)
            make.height.equalTo(20)
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
            make.height.equalTo(20)
        }
        
        createButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
    }
}
