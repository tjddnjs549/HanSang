//
//  SignUpViewController.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/26.
//

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
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
