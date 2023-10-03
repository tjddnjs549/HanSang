//
//  SettingViewController.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/03.
//

import UIKit

class SettingViewController: UIViewController {
    private let settingView = SettingView()
    private let myPageViewModel = MyPageViewModel()
    private var settingsItems: [SettingItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension SettingViewController {
    func setup() {
        view = settingView
        settingView.tableView.dataSource = self
        settingView.tableView.delegate = self

        settingView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        settingView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        let autoLoginItem = SettingItem(type: .autoLogin, title: "자동 로그인", isSwitchOn: true)
        let editProfileItem = SettingItem(type: .editProfile, title: "내 정보 변경", icon: UIImage(named: ">"), isSwitchOn: false)
        let logoutItem = SettingItem(type: .logout, title: "로그아웃", icon: UIImage(named: ">"), isSwitchOn: false)
        settingsItems = [autoLoginItem, editProfileItem, logoutItem]
    }

    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        myPageViewModel.deleteAllUsers()
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCustomCell.identifier, for: indexPath) as? SettingCustomCell else {
            return UITableViewCell()
        }

        let settingItem = settingsItems[indexPath.row]
        cell.configure(settingItem)
        if cell.switchControl.isOn {
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        } else {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingItem = settingsItems[indexPath.row]

        switch settingItem.type {
            case .autoLogin:
                break
            case .editProfile:
                let editVC = EditViewController()
                editVC.modalPresentationStyle = .fullScreen
                present(editVC, animated: true, completion: nil)
            case .logout:
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    let loginViewController = LoginViewController()
                    let navigationController = UINavigationController(rootViewController: loginViewController)
                    sceneDelegate.window?.rootViewController = navigationController
                }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

struct SettingItem {
    enum ItemType {
        case autoLogin
        case editProfile
        case logout
    }

    let type: ItemType
    let title: String
    let icon: UIImage?
    var isSwitchOn: Bool

    init(type: ItemType, title: String, icon: UIImage? = nil, isSwitchOn: Bool) {
        self.type = type
        self.title = title
        self.icon = icon
        self.isSwitchOn = isSwitchOn
    }
}
