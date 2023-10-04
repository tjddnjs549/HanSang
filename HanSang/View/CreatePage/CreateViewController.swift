//
//  CreateViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit
import SnapKit
import PhotosUI

class CreateViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private var page = 1
    
    private let recipeInfoView = RecipeInfoView()
    private let materialView = MaterialView()
    private let recipeView = RecipeView()
    // 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎 수정(private 삭제) 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎
    let nextButton: UIButton = {
//        $0.isEnabled = false
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        registerNotification()
        recipeInfoView.imageAddButton.addTarget(self, action:  #selector(touchUpAddButton), for: .touchUpInside)
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        
        navigationItem.title = "레시피 작성"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(touchUpCloseButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        materialView.isHidden = true
        recipeView.isHidden = true
    }
    
    private func setupLayout() {
        [recipeInfoView, materialView, recipeView, nextButton].forEach {
            view.addSubview($0)
        }
        
        recipeInfoView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(nextButton.snp.top).offset(10)
        }
        
        materialView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(nextButton.snp.top).offset(10)
        }
        
        recipeView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(nextButton.snp.top).offset(10)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    //MARK: - @objc
    
    @objc func touchUpNextButton() {
        page += 1

        if page == 1 {
            recipeInfoView.isHidden = false
            materialView.isHidden = true
            recipeView.isHidden = true
        } else if page == 2 {
            recipeInfoView.isHidden = true
            materialView.isHidden = false
            recipeView.isHidden = true
        } else {
            nextButton.setTitle("작성완료", for: .normal)
            recipeInfoView.isHidden = true
            materialView.isHidden = true
            recipeView.isHidden = false
        }
    }
    
    @objc func touchUpCloseButton() {
        let tabBarViewController = TabbarViewController()
        tabBarViewController.modalPresentationStyle = .fullScreen
        tabBarViewController.modalTransitionStyle = .crossDissolve
        present(tabBarViewController, animated: true)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        guard let alert = notification.object as? UIAlertController else { return }
        present(alert, animated: true)
    }
    
    
    @objc func touchUpAddButton() {
        setupImagePicker()
    }
    
    // MARK: - Custom Method
    
    private func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: CreateRecipeTableViewCell.timerNotificationName, object: nil)
    }
}
extension CreateViewController: PHPickerViewControllerDelegate {
    
    func setupImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard !results.isEmpty else {
            dismiss(animated: true, completion: nil)
            return
        }
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.recipeInfoView.imageView.image = image as? UIImage
                    self.recipeInfoView.sendSubviewToBack(self.recipeInfoView.imageAddButton)
                    self.recipeInfoView.imageView.layer.cornerRadius = 0.0
                }
            }
            dismiss(animated: true, completion: nil)
        } else {
            print("ERROR❗️")
        }
    }
}
