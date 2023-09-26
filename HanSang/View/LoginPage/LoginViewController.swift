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
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // 메인화면 이동 방법 수정 필요
    @objc func loginButtonTapped() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
