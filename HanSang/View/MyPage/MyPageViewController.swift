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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}

private extension MyPageViewController {
    func setup() {
        view = myPageView
        myPageView.collectionView.dataSource = self
        myPageView.collectionView.delegate = self
        
        navigationItem.title = "user id"
        
        // 로그인 페이지 테스트용
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginButtonTapped))
    }
    
    // 로그인 페이지 테스트용
    @objc func loginButtonTapped() {
        let loginPageVC = LoginViewController()
        navigationController?.pushViewController(loginPageVC, animated: true)
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
//extension MyPageViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (view.frame.width/3)-20
//        return CGSize(width: size, height: size)
//   }
//}

// MyPageCustomCell2
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width - 40
        return CGSize(width: size, height: 200)
   }
}
