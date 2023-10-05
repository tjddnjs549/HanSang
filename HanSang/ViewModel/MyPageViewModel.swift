//
//  MyPageViewModel.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/02.
//

import Foundation
import UIKit

class MyPageViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchUserInfo() {
        let request = User.fetchRequest()

        do {
            SignUpViewModel.user = try context.fetch(request)
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
    
    func deleteAllUsers() {
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
    
}
