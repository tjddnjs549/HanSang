//
//  EditViewController.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/03.
//

import PhotosUI
import UIKit

class EditViewController: UIViewController {
    private let editView = EditView()
    private let editViewModel = EditViewModel()
    private var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        hideKeyboard()
        registerForKeyboardNotifications()
    }
}

private extension EditViewController {
    func setup() {
        view = editView
        editView.pwTextField.delegate = self
        editView.confirmPwTextField.delegate = self
        editView.nicknameTextField.delegate = self

        editView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        editView.createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        editView.profilePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editProfilePicture)))
        editView.pwCheckedButton.addTarget(self, action: #selector(pwCheckedButtonTapped), for: .touchUpInside)
        editView.confirmPwCheckedButton.addTarget(self, action: #selector(verifyPwCheckedButtonTapped), for: .touchUpInside)
        editView.nicknameCheckedButton.addTarget(self, action: #selector(nicknameCheckedButtonTapped), for: .touchUpInside)
    }

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        {
            let keyboardHeight = keyboardFrame.height

            if let activeTextField = activeTextField {
                let textFieldFrameInWindow = activeTextField.convert(activeTextField.bounds, to: nil)
                let maxY = textFieldFrameInWindow.maxY

                if maxY > (view.frame.size.height - keyboardHeight) {
                    let scrollOffset = maxY - (view.frame.size.height - keyboardHeight)
                    view.frame.origin.y = -scrollOffset
                }
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

extension EditViewController: PHPickerViewControllerDelegate {
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

        guard let selectedImage = results.first?.itemProvider else { return }

        selectedImage.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            } else if let image = image as? UIImage {
                DispatchQueue.main.async {
                    self?.editView.profilePicture.image = image
                }
            }
        }
    }
}

extension EditViewController {
    @objc func pwCheckedButtonTapped() {
        editView.pwTextField.isSecureTextEntry.toggle()
        let imageName = editView.pwTextField.isSecureTextEntry ? "eyes" : "eyes.inverse"
        editView.pwCheckedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc func verifyPwCheckedButtonTapped() {
        editView.confirmPwTextField.isSecureTextEntry.toggle()
        let imageName = editView.confirmPwTextField.isSecureTextEntry ? "eyes" : "eyes.inverse"
        editView.confirmPwCheckedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc func nicknameCheckedButtonTapped() {
        let nickname = editView.nicknameTextField.text ?? ""
        if isValidNickname(nickname) {
            if isNicknameAlreadyRegistered(nickname) {
                editView.nicknameTextFieldDescription.text = "이미 존재하는 닉네임입니다."
                editView.nicknameTextFieldDescription.isHidden = false
            } else {
                editView.nicknameTextFieldDescription.text = "사용 가능한 닉네임입니다."
                editView.nicknameTextFieldDescription.isHidden = false
            }
        }
    }

    // MARK: - 회원가입 정규식 유효성 검사

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

    private func isNicknameAlreadyRegistered(_ nickname: String) -> Bool {
        let existingUser = editViewModel.getUserNickname(nickname)
        return (existingUser != nil) ? true : false
    }

    @objc func createButtonTapped() {
        guard let image = editView.profilePicture.image,
              let pw = editView.pwTextField.text,
              let nickname = editView.nicknameTextField.text
        else {
            return
        }

        // 중복 확인
        if isNicknameAlreadyRegistered(nickname) {
            editView.nicknameTextFieldDescription.text = "이미 존재하는 닉네임입니다."
            return
        }

        if let user = LoginViewModel.loginUser {
            editViewModel.editUser(user, editImage: image, editPW: pw, editNickname: nickname)
            editViewModel.fetchUserInfo()

            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
}

extension EditViewController: UITextFieldDelegate {
    // Enter 시 다음 텍스트필드로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == editView.pwTextField {
            editView.confirmPwTextField.becomeFirstResponder()
        } else if textField == editView.confirmPwTextField {
            editView.nicknameTextField.becomeFirstResponder()
        } else if textField == editView.nicknameTextField {
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        if textField == editView.pwTextField {
            editView.pwTextFieldDescription.isHidden = false
        } else if textField == editView.confirmPwTextField {
            editView.confirmPwTextFieldDescription.isHidden = false
        } else {
            editView.nicknameTextFieldDescription.isHidden = false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == editView.pwTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            let passwordPattern = "^(?=.*[A-Za-z\\d@$!%*?&#]).{4,}$"
            let isValidPassword = (newText.range(of: passwordPattern, options: .regularExpression) != nil)

            if isValidPassword {
                editView.pwTextFieldDescription.isHidden = true
            } else {
                editView.pwTextFieldDescription.text = "비밀번호는 4자 이상 대소문자, 숫자, 특수문자 중 적어도 하나를 포함해야 합니다."
            }
        } else if textField == editView.confirmPwTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            let isMatchingPassword = (newText == editView.pwTextField.text)

            if isMatchingPassword {
                editView.confirmPwTextFieldDescription.isHidden = true
            } else {
                editView.confirmPwTextFieldDescription.text = "비밀번호가 일치하지 않습니다."
            }
        } else if textField == editView.nicknameTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            let nicknamePattern = "^.{2,8}$"
            let isValidNickname = (newText.range(of: nicknamePattern, options: .regularExpression) != nil)

            if isValidNickname {
                editView.nicknameTextFieldDescription.isHidden = true
            } else {
                editView.nicknameTextFieldDescription.text = "닉네임은 2-8자이어야 합니다."
            }
        }

        if isAllFieldsValid() {
            editView.createButton.backgroundColor = ColorGuide.main
            editView.createButton.setTitleColor(.white, for: .normal)
            editView.createButton.isEnabled = true
        } else {
            editView.createButton.backgroundColor = ColorGuide.inputLine
            editView.createButton.isEnabled = false
        }

        return true
    }

    private func isAllFieldsValid() -> Bool {
        if let pw = editView.pwTextField.text,
           let confirmPw = editView.confirmPwTextField.text,
           let nickname = editView.nicknameTextField.text
        {
            return !pw.isEmpty && !confirmPw.isEmpty && !nickname.isEmpty
        }
        return false
    }
}
