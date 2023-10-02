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
        let request = User.fetchRequest()

        do {
            SignUpViewModel.user = try context.fetch(request)
        } catch {
            print("🚨 유저 정보 불러오기 오류")
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

    func saveLogInUserInfo(_ user: User) {
        do {
            try context.save()
            LoginViewModel.loginUser = user
        } catch {
            fatalError("🚨 로그인 정보 저장 오류")
        }
    }
}
