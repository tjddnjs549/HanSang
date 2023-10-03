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
    let images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        print("로드 유저: ", LoginViewModel.loginUser?.id)
        setup()
        loadUserInfo()
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
           let id = user.id,
           let nickname = user.nickname,
           let recipeCount = user.content?.count
        {
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
        let size = (view.bounds.size.width - 76) / 2
        return CGSize(width: size, height: 182)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
