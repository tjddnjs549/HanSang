//
//  MainViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.backgroundColor = .link
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.leading.top.equalTo(100)
        }
        
        loginButton.addTarget(self, action: #selector(loginPageVC), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func loginPageVC() {
        let loginPageVC = LoginViewController()
        navigationController?.pushViewController(loginPageVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
