//
//  EditView.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/03.
//

import UIKit
import SnapKit

class EditView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let contentView = UIView()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = ColorGuide.black
        button.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        return button
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "내 정보 변경"
        label.font = FontGuide.size32Bold
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text =
            """
            안녕하세요.
            함께 한상 거하게 차려볼까요?
            """
        label.font = FontGuide.size19
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.snp.makeConstraints { make in
            make.width.equalTo(227)
            make.height.equalTo(52)
        }
        return label
    }()
    
    let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.backgroundColor = ColorGuide.subButton
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        return imageView
    }()
    
    let edit: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pencil")
        imageView.backgroundColor = ColorGuide.subButton
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = ColorGuide.inputLine.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        return imageView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = FontGuide.size14
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해주세요", attributes: [.font: FontGuide.size16])
        textField.textColor = ColorGuide.textHint
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.borderColor = ColorGuide.inputLine.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return textField
    }()
    
    private lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabel, idTextField])
        stackView.axis = .vertical
        stackView.spacing = 9
        return stackView
    }()
    
    private let pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = FontGuide.size14
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    let pwTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요", attributes: [.font: FontGuide.size16])
        textField.textColor = ColorGuide.textHint
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.borderColor = ColorGuide.inputLine.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return textField
    }()
    
    let pwTextFieldDescription: UILabel = {
        let label = UILabel()
        label.text = "  🚨 필수 입력 사항입니다."
        label.font = FontGuide.size14
        label.textColor = ColorGuide.main
        label.textAlignment = .left
        label.numberOfLines = 2
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
        stackView.spacing = 9
        return stackView
    }()
    
    private let confirmPwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = FontGuide.size14
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    let confirmPwTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 다시 입력해주세요", attributes: [.font: FontGuide.size16])
        textField.textColor = ColorGuide.textHint
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.textContentType = .none
        textField.layer.borderColor = ColorGuide.inputLine.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return textField
    }()
    
    let confirmPwTextFieldDescription: UILabel = {
        let label = UILabel()
        label.text = "  🚨 필수 입력 사항입니다."
        label.font = FontGuide.size14
        label.textColor = ColorGuide.main
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
        stackView.spacing = 9
        return stackView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = FontGuide.size14
        label.textColor = ColorGuide.black
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요", attributes: [.font: FontGuide.size16])
        textField.textColor = ColorGuide.textHint
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.borderColor = ColorGuide.inputLine.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return textField
    }()
    
    let nicknameTextFieldDescription: UILabel = {
        let label = UILabel()
        label.text = "  🚨 필수 입력 사항입니다."
        label.font = FontGuide.size14
        label.textColor = ColorGuide.main
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    let nicknameCheckedButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = FontGuide.size14
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorGuide.subButton
        button.layer.cornerRadius = 4
        button.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(40)
        }
        return button
    }()
    
    private lazy var nicknameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, nicknameTextField, nicknameTextFieldDescription])
        stackView.axis = .vertical
        stackView.spacing = 9
        return stackView
    }()
    
    private lazy var signUpInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idStackView, pwStackView, confirmPwStackView, nicknameStackView])
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = FontGuide.size19Bold
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorGuide.main
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

private extension EditView {
    func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(900)
       }
        
        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(24)
        }
        
        contentView.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(39)
            make.leading.equalTo(30)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(16)
            make.leading.equalTo(30)
        }
        
        contentView.addSubview(profilePicture)
        profilePicture.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.top)
            make.trailing.equalToSuperview().offset(-33)
        }
        
        contentView.addSubview(edit)
        edit.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.top).offset(56)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        contentView.addSubview(signUpInfoStackView)
        signUpInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        contentView.addSubview(pwCheckedButton)
        pwCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(pwTextField.snp.centerY)
            make.trailing.equalTo(pwTextField.snp.trailing).offset(-10)
            make.width.height.equalTo(20)
        }
        
        contentView.addSubview(confirmPwCheckedButton)
        confirmPwCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(confirmPwTextField.snp.centerY)
            make.trailing.equalTo(confirmPwTextField.snp.trailing).offset(-10)
            make.width.height.equalTo(20)
        }
        
        contentView.addSubview(nicknameCheckedButton)
        nicknameCheckedButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameTextField.snp.centerY)
            make.trailing.equalTo(nicknameTextField.snp.trailing).offset(-8)
        }
        
        contentView.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.top.equalTo(signUpInfoStackView.snp.bottom).offset(68)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
}
