//
//  LoginViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var loginUser: User?
    private var activeTextField: UITextField?

    func fetchUserInfo() {
        let request = User.fetchRequest()

        do {
            SignUpViewController.user = try context.fetch(request)
        } catch {
            print("🚨 유저 정보 불러오기 오류")
        }
    }

    func getUserId(_ id: String) -> User? {
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("🚨 유저 정보 찾을 수 없음: \(error)")
            return nil
        }
    }
    
    func saveLogInUserInfo(_ user: User) {
        do {
            try context.save()
            LoginViewController.loginUser = user
        } catch {
            fatalError("🚨 로그인 정보 저장 오류")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        if let user = getUserId(id) {
            if user.pw == pw {
                saveLogInUserInfo(user)
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
