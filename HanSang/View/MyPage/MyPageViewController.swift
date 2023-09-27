//
//  MyPageViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

class MyPageViewController: UIViewController {
    private let myPageView = MyPageView2()
    let images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
    ]

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchUserInfo() {
        let request = User.fetchRequest()

        do {
            SignUpViewController.user = try context.fetch(request)
        } catch {
            print("🚨 유저 정보 불러오기 오류")
        }
    }

    func deleteLogInUserInfo() {
        let request = User.fetchRequest()

        do {
            let users = try context.fetch(request)
            for user in users {
                context.delete(user)
            }
            try context.save()
        } catch {
            print("🚨 로그아웃 유저 정보 저장 에러")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        loadUserInfo()
    }
}

private extension MyPageViewController {
    func setup() {
        view = myPageView
        myPageView.collectionView.dataSource = self
        myPageView.collectionView.delegate = self

        // 로그인 페이지 테스트용
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginButtonTapped))
        myPageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    func loadUserInfo() {
        fetchUserInfo()
        if let user = SignUpViewController.user?.first,
           let id = user.id,
           let nickname = user.nickname,
           let recipeCount = user.content?.count {
            if let imageData = user.profilePicture,
               let image = UIImage(data: imageData) {
                myPageView.profilePicture.image = image
            } else {
                myPageView.profilePicture.image = UIImage(systemName: "person.fill")
            }
            navigationItem.title = id
            myPageView.nicknameLabel.text = nickname
            if recipeCount == 0 {
                myPageView.recipeCount.text = "0"
            } else {
                myPageView.recipeCount.text = String(recipeCount)
            }
        }
    }

    // 로그인 페이지 테스트용
    @objc func loginButtonTapped() {
        let loginPageVC = LoginViewController()
        navigationController?.pushViewController(loginPageVC, animated: true)
    }

    @objc func logoutButtonTapped() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")

        // 로그인 화면으로 이동
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            sceneDelegate.window?.rootViewController = navigationController
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCustomCell2.identifier, for: indexPath) as? MyPageCustomCell2 else {
            fatalError()
        }
        let image = images[indexPath.row]
        cell.configure(image)
        return cell
    }
}

// MyPageCustomCell
// extension MyPageViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (view.frame.width/3)-20
//        return CGSize(width: size, height: size)
//   }
// }

// MyPageCustomCell2
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width - 40
        return CGSize(width: size, height: 200)
    }
}
