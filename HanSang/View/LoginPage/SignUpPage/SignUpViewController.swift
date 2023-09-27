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
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var user: [User]?

    func fetchUserInfo() {
        let request = User.fetchRequest()

        do {
            user = try context.fetch(request)
        } catch {
            print("🚨 유저 정보 불러오기 오류")
        }
    }

    func getUser(_ id: String) -> User? {
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            return try context.fetch(request).first
        } catch {
            print("🚨 유저 정보 찾을 수 없음: \(error)")
            return nil
        }
    }

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
        // 아이디 정규식: 소문자, 숫자로 이루어진 4~12자
        let idRegex = "^[a-z0-9]{4,12}$"
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
        return idPredicate.evaluate(with: id)
    }

    private func isValidPw(_ pw: String) -> Bool {
        // 비밀번호 정규식: 대소문자, 숫자, 특수문자 중 적어도 하나를 포함하고 4자 이상
        let pwRegex = "^(?=.*[A-Za-z\\d@$!%*?&#]).{4,}$"
        let pwPredicate = NSPredicate(format: "SELF MATCHES %@", pwRegex)
        return pwPredicate.evaluate(with: pw)
    }

    private func doPasswordsMatch(_ pw: String, _ confirmPw: String) -> Bool {
        return pw == confirmPw
    }

    private func isValidNickname(_ nickname: String) -> Bool {
        // 닉네임 정규식: 2~8자의 문자열
        let nicknameRegex = "^.{2,8}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return nicknamePredicate.evaluate(with: nickname)
    }

    private func isIdAlreadyRegistered(_ id: String) -> Bool {
        let existingUser = getUser(id)
        return (existingUser != nil) ? true : false
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == signUpView.idTextField {
            signUpView.idTextFieldDescription.isHidden = false
        } else if textField == signUpView.pwTextField {
            signUpView.pwTextFieldDescription.isHidden = false
        } else if textField == signUpView.confirmPwTextField {
            signUpView.confirmPwTextFieldDescription.isHidden = false
        } else {
            signUpView.nicknameTextFieldDescription.isHidden = false
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == signUpView.idTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            let idPattern = "^[a-z0-9]{4,12}$"
            let isValidId = (newText.range(of: idPattern, options: .regularExpression) != nil)

            if isValidId {
                signUpView.idTextFieldDescription.isHidden = true
            } else {
                signUpView.idTextFieldDescription.text = "아이디는 소문자, 숫자로 이루어진 4~12자이어야 합니다."
            }

        } else if textField == signUpView.pwTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            let passwordPattern = "^(?=.*[A-Za-z\\d@$!%*?&#]).{4,}$"
            let isValidPassword = (newText.range(of: passwordPattern, options: .regularExpression) != nil)

            if isValidPassword {
                signUpView.pwTextFieldDescription.isHidden = true
            } else {
                signUpView.pwTextFieldDescription.text = "비밀번호는 4자 이상 대소문자, 숫자, 특수문자 중 적어도 하나를 포함해야 합니다."
            }
        } else if textField == signUpView.confirmPwTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            let isMatchingPassword = (newText == signUpView.pwTextField.text)

            if isMatchingPassword {
                signUpView.confirmPwTextFieldDescription.isHidden = true
            } else {
                signUpView.confirmPwTextFieldDescription.text = "비밀번호가 일치하지 않습니다."
            }
        } else if textField == signUpView.nicknameTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            let nicknamePattern = "^.{2,8}$"
            let isValidNickname = (newText.range(of: nicknamePattern, options: .regularExpression) != nil)

            if isValidNickname {
                signUpView.nicknameTextFieldDescription.isHidden = true
            } else {
                signUpView.nicknameTextFieldDescription.text = "닉네임은 2-8자이어야 합니다."
            }
        }

        if isAllFieldsValid() {
            signUpView.createButton.backgroundColor = ColorGuide.yellow900
            signUpView.createButton.isEnabled = true
        } else {
            signUpView.createButton.backgroundColor = .systemGray6
            signUpView.createButton.isEnabled = false
        }

        return true
    }

    private func isAllFieldsValid() -> Bool {
        if let id = signUpView.idTextField.text,
           let pw = signUpView.pwTextField.text,
           let confirmPw = signUpView.confirmPwTextField.text,
           let nickname = signUpView.nicknameTextField.text {
            return !id.isEmpty && !pw.isEmpty && !confirmPw.isEmpty && !nickname.isEmpty
        }
        return false
    }
}
