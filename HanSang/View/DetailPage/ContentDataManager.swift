//
//  ContentDataManager.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/29.
//

import UIKit
import CoreData

final class ContentDataManager {
    
    static let shared = ContentDataManager()
    private init() {}
 
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context: NSManagedObjectContext? = appDelegate?.persistentContainer.viewContext
    let modelName: String = "Content"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getContentListFromCoreData() -> [Content] {
        var content: [Content] = []
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            let idOreder = NSSortDescriptor(key: "id", ascending: false)
            request.sortDescriptors = [idOreder]
            do {
                if let fetchedContentList = try context.fetch(request) as? [Content] {
                    content = fetchedContentList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return content
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveToDoData(toDoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let contentData = NSManagedObject(entity: entity, insertInto: context) as? Content {

                    
                    //작성 - 저장할 것들
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기
    func deleteToDo(data: Content, completion: @escaping () -> Void) {
        guard let id = data.id else { return }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            do {
                if let fetchedContentList = try context.fetch(request) as? [Content] {
                    if let targetContent = fetchedContentList.first {
                        context.delete(targetContent)
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기
    func updateToDo(newData: Content, completion: @escaping () -> Void) {
        guard let id = newData.id else { return }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            do {
                if let fetchedContentList = try context.fetch(request) as? [Content] {
                    if var targetContent = fetchedContentList.first {
                        targetContent = newData
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
            }
        }
    }
}
