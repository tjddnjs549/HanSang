//
//  LoginViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}

private extension LoginViewController {
    func setup() {
        view = loginView
        loginView.pw.delegate = self
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginView.pwCheckedButton.addTarget(self, action: #selector(pwCheckedButtonTapped), for: .touchUpInside)
    }
    
    // 메인화면 이동 방법 수정 필요
    @objc func loginButtonTapped() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
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
}

extension LoginViewController: UITextFieldDelegate {
    
}
