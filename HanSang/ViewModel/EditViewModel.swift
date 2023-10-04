//
//  EditViewModel.swift
//  HanSang
//
//  Created by t2023-m0076 on 2023/10/03.
//

import Foundation
import UIKit

class EditViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    func editUser(_ user: User, editImage: UIImage?, editPW: String, editNickname: String) {
        if let imageData = editImage?.jpegData(compressionQuality: 1.0) {
            user.profilePicture = imageData
        } else {
            print("🚨 이미지 저장 에러")
        }
        
        user.pw = editPW
        user.nickname = editNickname

        do {
            try context.save()
        } catch {
            print("🚨 유저 수정 오류")
        }
    }

}
