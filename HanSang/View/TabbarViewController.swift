//
//  ViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit


class TabbarViewController: UITabBarController {
    enum TabBarMenu: Int {
        case Main = 0
        case Timer
        case Create
        case BookMark
        case MyPage
    } // 페이지 수만큼 case 넣기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabControllers()
        self.delegate = self
    }
    
    func setTabControllers() {
        let mainVC = MainViewController()
        let naviMainVC = UINavigationController(rootViewController: mainVC)
        let timerVC = TimerViewController()
        let naviTimerVC = UINavigationController(rootViewController: timerVC)
        let createVC = CreateViewController()
        let naviCreateVC = UINavigationController(rootViewController: createVC)
        let bookMarkVC = BookMarkViewController()
        let naviBookmarkVC = UINavigationController(rootViewController: bookMarkVC)
        let mypageVC = MyPageViewController()
        let naviMyPageVC = UINavigationController(rootViewController: mypageVC)
       
       
        // init tabbar controller
        let controllers = [naviMainVC, naviTimerVC, naviCreateVC, naviBookmarkVC, naviMyPageVC]
        self.viewControllers = controllers
        
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        
        self.tabBar.tintColor = .systemYellow

        // 홈
        self.tabBar.items![0].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![0].image = UIImage(systemName: "house.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        self.tabBar.items![0].selectedImage = UIImage(systemName: "house.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemYellow)
        self.tabBar.items![0].title = "홈"
        
        // 타이머
        self.tabBar.items![1].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![1].image = UIImage(systemName: "timer.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        self.tabBar.items![1].selectedImage = UIImage(systemName: "timer.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemYellow)
        self.tabBar.items![1].title = "타이머"
        
        // 추가
        self.tabBar.items![2].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![2].image = UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        self.tabBar.items![2].selectedImage = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemYellow)
        self.tabBar.items![2].title = "추가"
        
        // 북마크
        self.tabBar.items![3].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![3].image = UIImage(systemName: "heart.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        self.tabBar.items![3].selectedImage = UIImage(systemName: "heart.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemYellow)
        self.tabBar.items![3].title = "북마크"
        
        // 마이페이지
        self.tabBar.items![4].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![4].image = UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        self.tabBar.items![4].selectedImage = UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemYellow)
        self.tabBar.items![4].title = "마이페이지"
    }
}

extension TabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          
            return false
        }
        if fromView != toView {
            //UIView.transition: 전환 효과를 적용
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
}


