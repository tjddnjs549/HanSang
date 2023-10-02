//
//  MyPageViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit
import PhotosUI

class MyPageViewController: UIViewController {
    private let myPageView = MyPageView()
    let images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
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
    
    func editUser(_ user: User, _ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            user.profilePicture = imageData
        } else {
            print("🚨 이미지 저장 에러")
        }

        do {
            try context.save()
            self.fetchUserInfo()
        } catch {
            print("🚨 유저 생성 오류")
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
    
    @objc func deleteAllUsers() {
        let request = User.fetchRequest()

        do {
            let users = try context.fetch(request)
            for user in users {
                context.delete(user)
            }
            try context.save()
            fetchUserInfo()
        } catch {
            print("🚨 Error: Delete all tasks")
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
        
        myPageView.profilePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editProfilePicture)))
        
        if let originalImage = UIImage(named: "HANSANG") {
            let tintedImage = originalImage.withTintColor(ColorGuide.main)
            let button = UIBarButtonItem(image: tintedImage, style: .plain, target: self, action: #selector(deleteAllUsers))
            button.tintColor = ColorGuide.main
            navigationItem.leftBarButtonItem = button
        }
        
        if let logOutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right") {
            let originalSize = logOutImage.size
            let scaledSize = CGSize(width: originalSize.width * 0.8, height: originalSize.height * 0.8)
            let renderer = UIGraphicsImageRenderer(size: scaledSize)
            let scaledLogOutImage = renderer.image { _ in
                logOutImage.draw(in: CGRect(origin: .zero, size: scaledSize))
            }
            let coloredLogOutImage = scaledLogOutImage.withTintColor(ColorGuide.textHint, renderingMode: .alwaysOriginal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: coloredLogOutImage, style: .plain, target: self, action: #selector(logoutButtonTapped))
        }
    }

    func loadUserInfo() {
        if let user = LoginViewController.loginUser,
           let id = user.id,
           let nickname = user.nickname,
           let recipeCount = user.content?.count {
            if let imageData = user.profilePicture,
               let image = UIImage(data: imageData) {
                myPageView.profilePicture.image = image
            } else {
                myPageView.profilePicture.image = UIImage(named: "profile")
            }
            myPageView.nickname.text = nickname
            if recipeCount == 0 {
                myPageView.recipeCount.text = "0"
            } else {
                myPageView.recipeCount.text = String(recipeCount)
            }
        }
    }

    // 로그아웃 별도 페이지로 이동 예정(-> 설정 페이지 추가)
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

extension MyPageViewController: PHPickerViewControllerDelegate {
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
                    self?.myPageView.profilePicture.image = image
                    self?.editUser(LoginViewController.loginUser!, image)
                }
            }
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else {
            fatalError()
        }
        let image = images[indexPath.row]
        cell.configure(image)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = ColorGuide.textHint.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 12
        return cell
    }
}

 extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width - 76)/2
        return CGSize(width: size, height: 182)
   }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 16
     }
 }
