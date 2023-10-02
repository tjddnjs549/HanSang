//
//  SceneDelegate.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import CoreData
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let loginViewModel = LoginViewModel()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            print("자동로그인 여부: ", isLoggedIn())
            if isLoggedIn() {
                // 자동 로그인 가능한 경우 user ID 불러오기
                if let loggedInUserId = loadLoggedInUserId(),
                   let user = loginViewModel.getUserId(loggedInUserId) {
                    // 로그인 성공한 사용자 정보를 저장
                    LoginViewModel.loginUser = user
                    window.rootViewController = TabbarViewController()
                } else {
                    // 사용자 정보를 불러올 수 없는 경우 로그인 페이지로 이동
                    window.rootViewController = LoginViewController()
                }
            } else {
                // 자동 로그인이 아닌 경우 로그인 페이지로 이동
                window.rootViewController = LoginViewController()
            }
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    private func loadLoggedInUserId() -> String? {
        return UserDefaults.standard.string(forKey: "loggedInUserId")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
