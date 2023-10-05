//
//  MyPageViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import PhotosUI
import UIKit

class MyPageViewController: UIViewController {
    private let myPageView = MyPageView()
    private let myPageViewModel = MyPageViewModel()
    
    var userContents: [Content] = [] {
        didSet {
            myPageView.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserInfo()
        loadUserContents()
        setup()
    }
}

private extension MyPageViewController {
    func setup() {
        view = myPageView
        myPageView.collectionView.dataSource = self
        myPageView.collectionView.delegate = self

        if let originalImage = UIImage(named: "HANSANG") {
            let tintedImage = originalImage.withTintColor(ColorGuide.main)
            let button = UIBarButtonItem(image: tintedImage, style: .plain, target: nil, action: nil)
            button.tintColor = ColorGuide.main
            navigationItem.leftBarButtonItem = button
        }

        if let settingImage = UIImage(named: "setting") {
            let originalSize = settingImage.size
            let scaledSize = CGSize(width: originalSize.width * 0.8, height: originalSize.height * 0.8)
            let renderer = UIGraphicsImageRenderer(size: scaledSize)
            let scaledSettingImage = renderer.image { _ in
                settingImage.draw(in: CGRect(origin: .zero, size: scaledSize))
            }
            let coloredSettingImage = scaledSettingImage.withTintColor(ColorGuide.textHint, renderingMode: .alwaysOriginal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: coloredSettingImage, style: .plain, target: self, action: #selector(settingButtonTapped))
        }
    }

    @objc func settingButtonTapped() {
        let settingVC = SettingViewController()
        settingVC.modalPresentationStyle = .fullScreen
        present(settingVC, animated: true, completion: nil)
    }

    func loadUserInfo() {
        if let user = LoginViewModel.loginUser,
           let nickname = user.nickname,
           let recipeCount = user.content?.count {
            if let imageData = user.profilePicture,
               let image = UIImage(data: imageData)
            {
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
    
    func loadUserContents() {
        if let user = LoginViewModel.loginUser {
            if let contents = myPageViewModel.getContentForUser(user) {
                userContents = contents
            }
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userContents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else {
            fatalError()
        }
        
        let content = userContents[indexPath.row]
        if let data = content.picture, let image = UIImage(data: data) {
            cell.configure(image, content.title ?? "", content.time ?? "")
        } else {
            print("🚨 User Content 불러오기 오류")
        }
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width - 76) / 2
        return CGSize(width: size, height: 182)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
