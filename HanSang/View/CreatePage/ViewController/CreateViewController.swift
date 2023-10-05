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
    private let coreDataManager = ContentDataManager.shared
    
    private let recipeInfoView = RecipeInfoView()
    private let materialView = MaterialView()
    private let recipeView = RecipeView()
    
    let nextButton: UIButton = {
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = ColorGuide.yellow900
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
        
        setupRecipeInfoView()
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
        if page == 3 {
            coreDataManager.saveRecipe(
                content: recipeInfoView.getRecipeInfo(),
                materials: materialView.materialList,
                recipes: recipeView.recipeList)
            print("List:\(coreDataManager.getContentListFromCoreData())")
            return
        }
        
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
    
    @objc func handleTimerNotification(_ notification: Notification) {
        guard let alert = notification.object as? UIAlertController else { return }
        present(alert, animated: true)
    }
    
    @objc func handelPresentNotification(_ notification: Notification) {
        guard let picker = notification.object as? PHPickerViewController else { return }
        present(picker, animated: true)
    }
    
    @objc func handelDismissNotification(_ notification: Notification) {
        dismiss(animated: true)
    }
    
    // MARK: - Custom Method
    
    private func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimerNotification), name: NotificationName.timer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handelPresentNotification), name: NotificationName.present, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handelDismissNotification), name: NotificationName.dismiss, object: nil)
    }
    
    private func setupRecipeInfoView() {
        recipeInfoView.presentViewController = { picker in
            self.present(picker, animated: true)
        }
        
        recipeInfoView.dismissViewController = {
            self.dismiss(animated: true)
        }
    }
}

