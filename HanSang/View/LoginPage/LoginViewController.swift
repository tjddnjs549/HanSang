//
//  LoginViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let loginViewModel = LoginViewModel()
    private var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 로그인 상태 확인
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        print("로그인 상태: ", isLoggedIn)
        
        setup()
        hideKeyboard()
        registerForKeyboardNotifications()
    }
}

private extension LoginViewController {
    func setup() {
        view = loginView
        loginView.id.delegate = self
        loginView.pw.delegate = self
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginView.pwCheckedButton.addTarget(self, action: #selector(pwCheckedButtonTapped), for: .touchUpInside)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
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

    @objc func loginButtonTapped() {
        guard let id = loginView.id.text, let pw = loginView.pw.text else { return }
        
        if let user = loginViewModel.getUserId(id) {
            if user.pw == pw {
                UserDefaults.standard.set(user.id!, forKey: "loggedInUserId")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")

                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    let tabBarController = TabbarViewController()
                    sceneDelegate.window?.rootViewController = tabBarController
                }
            } else {
                showAlert(message: "비밀번호가 일치하지 않습니다.")
            }
        } else {
            showAlert(message: "존재하지 않는 계정입니다.")
        }
    }

    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }

    @objc func pwCheckedButtonTapped() {
        loginView.pw.isSecureTextEntry.toggle()
        let imageName = loginView.pw.isSecureTextEntry ? "eyes" : "eyes.inverse"
        loginView.pwCheckedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}
