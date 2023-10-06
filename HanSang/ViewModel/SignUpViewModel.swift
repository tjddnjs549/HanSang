//
//  SignUpViewModel.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/09/27.
//

import Foundation
import UIKit

class SignUpViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var user: [User]?
    
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

    func getUserNickname(_ nickname: String) -> User? {
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "nickname == %@", nickname)

        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("🚨 유저 정보 찾을 수 없음: \(error)")
            return nil
        }
    }

    func createUser(image: UIImage?, id: String, pw: String, nickname: String) {
        let newUser = User(context: context)
        if let imageData = image!.jpegData(compressionQuality: 1.0) {
            newUser.profilePicture = imageData
            newUser.id = id
            newUser.pw = pw
            newUser.nickname = nickname
        } else {
            print("🚨 이미지 저장 에러")
        }

        do {
            try context.save()
        } catch {
            print("🚨 유저 생성 오류")
        }
    }
    
}
