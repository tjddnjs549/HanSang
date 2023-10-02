//
//  LoginViewModel.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/02.
//

import Foundation
import UIKit

class LoginViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var loginUser: User?

    func fetchUserInfo() {
        guard let id = UserDefaults.standard.string(forKey: "loggedInUserId") else { return }

        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            let users = try context.fetch(request)
            if let user = users.first {
                LoginViewModel.loginUser = user
            }
        } catch {
            print("🚨 유저 정보 찾을 수 없음: \(error)")
        }
    }

    func getUserId(_ id: String) -> User? {
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("🚨 유저 정보 찾을 수 없음: \(error)")
            return nil
        }
    }
}
