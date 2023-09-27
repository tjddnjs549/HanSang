//
//  SignUpViewController.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

import PhotosUI
import UIKit

class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension SignUpViewController {
    func setup() {
        view = signUpView
        signUpView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        signUpView.createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        signUpView.profilePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editProfilePicture)))
        signUpView.pwCheckedButton.addTarget(self, action: #selector(pwCheckedButtonTapped), for: .touchUpInside)
        signUpView.confirmPwCheckedButton.addTarget(self, action: #selector(verifyPwCheckedButtonTapped), for: .touchUpInside)

        // TextField delegate
        signUpView.idTextField.delegate = self
        signUpView.pwTextField.delegate = self
        signUpView.confirmPwTextField.delegate = self
        signUpView.nicknameTextField.delegate = self
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

extension SignUpViewController: PHPickerViewControllerDelegate {
    @objc func editProfilePicture() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard let selectedImage = results.first?.itemProvider else {
            return
        }

        selectedImage.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            } else if let image = image as? UIImage {
                DispatchQueue.main.async {
                    self?.signUpView.profilePicture.image = image
                }
            }
        }
    }
}

extension SignUpViewController {
    @objc func pwCheckedButtonTapped() {
        signUpView.pwTextField.isSecureTextEntry.toggle()
        let imageName = signUpView.pwTextField.isSecureTextEntry ? "eyes" : "eyes.inverse"
        signUpView.pwCheckedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc func verifyPwCheckedButtonTapped() {
        signUpView.confirmPwTextField.isSecureTextEntry.toggle()
        let imageName = signUpView.confirmPwTextField.isSecureTextEntry ? "eyes" : "eyes.inverse"
        signUpView.confirmPwCheckedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // MARK: - 회원가입 정규식 유효성 검사
    private func isValidId(_ id: String) -> Bool {
        // 아이디 정규식: 소문자, 숫자로 이루어진 6~12자
        let idRegex = "^[a-z0-9]{6,12}$"
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
        return idPredicate.evaluate(with: id)
    }
    
    private func isValidPw(_ pw: String) -> Bool {
        // 비밀번호 정규식: 대소문자, 숫자, 특수문자만 허용 8자 이상
        let pwRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        let pwPredicate = NSPredicate(format: "SELF MATCHES %@", pwRegex)
        return pwPredicate.evaluate(with: pw)
    }
    
    private func doPasswordsMatch(_ pw: String, _ confirmPw: String) -> Bool {
        return pw == confirmPw
    }
    
    private func isValidNickname(_ nickname: String) -> Bool {
        // 닉네임 정규식: 2~20자의 문자열
        let nicknameRegex = "^.{2,20}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return nicknamePredicate.evaluate(with: nickname)
    }
    
    private func isIdAlreadyRegistered(_ id: String) -> Bool {
        // CoreData User 확인 로직 추가
        return false
    }

    @objc func createButtonTapped() {
        guard let id = signUpView.idTextField.text,
              let pw = signUpView.pwTextField.text,
              let confirmPw = signUpView.confirmPwTextField.text,
              let nickname = signUpView.nicknameTextField.text
        else {
            return
        }
        
        if isIdAlreadyRegistered(id) {
            // 중복 시 화면에 표시할 로직 추가
            return
        }
        
        if !isValidPw(pw) {
            // 비밀번호 정규식 오류 시 표시할 로직 추가
            return
        }
        
        if pw != confirmPw {
            // 비밀번호-비밀번호 확인 매칭 오류 시 표시할 로직 추가
            return
        }
        
        if !isValidNickname(nickname) {
            // 닉네임 정규식 오류 시 표시할 로직 추가
            return
        }
        
        // 추가할 항목: CoreData에 User 정보 저장
        
        // 회원가입 완료 시 로그인 페이지로 이동
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

}

extension SignUpViewController: UITextFieldDelegate {
    // Enter 시 다음 텍스트필드로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == signUpView.idTextField {
            signUpView.pwTextField.becomeFirstResponder()
        } else if textField == signUpView.pwTextField {
            signUpView.confirmPwTextField.becomeFirstResponder()
        } else if textField == signUpView.confirmPwTextField {
            signUpView.nicknameTextField.becomeFirstResponder()
        } else if textField == signUpView.nicknameTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // 계정 만들기 버튼 활성화
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let id = signUpView.idTextField.text,
           let pw = signUpView.pwTextField.text,
           let confirmPw = signUpView.confirmPwTextField.text,
           let nickname = signUpView.nicknameTextField.text {
            if !id.isEmpty && !pw.isEmpty && !confirmPw.isEmpty && !nickname.isEmpty {
                signUpView.createButton.backgroundColor = ColorGuide.yellow900
                signUpView.createButton.isEnabled = true
            } else {
                signUpView.createButton.backgroundColor = .systemGray6
                signUpView.createButton.isEnabled = false
            }
        }
        return true
    }
}
