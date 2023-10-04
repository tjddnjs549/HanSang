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
    
    
    // MARK: - [Read] 코어데이터에 저장된  content 데이터 모두 읽어오기
    func getContentListFromCoreData() -> [Content] {
        var content: [Content] = []
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            let dateOreder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOreder]
            do {
                if let fetchedContentList = try context.fetch(request) as? [Content] {
                    content = fetchedContentList
                }
                print("content 가져오는 것 성공")
            } catch {
                print("content 가져오는 것 실패")
            }
        }
        return content
    }
    
    // MARK: - [Read] 코어데이터에 저장된 category 데이터 모두 읽어오기
    func getCategoryListFromCoreData() -> [Category] {
        var category: [Category] = []
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Category")
            let idOreder = NSSortDescriptor(key: "id", ascending: false)
            request.sortDescriptors = [idOreder]
            do {
                if let fetchedCategoryList = try context.fetch(request) as? [Category] {
                    category = fetchedCategoryList
                }
                print("category 가져오는 것 성공")
            } catch {
                print("category 가져오는 것 실패")
            }
        }
        return category
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기 (첫번째 페이지에서 Content저장)
    func saveContentData(title: String, difficulty: String, kick: String, picture: Data, time: String, category: String) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let contentData = NSManagedObject(entity: entity, insertInto: context) as? Content {
                    contentData.id = UUID()
                    contentData.date = Date()
                    contentData.title = title
                    contentData.difficulty = difficulty
                    contentData.kick = kick
                    contentData.picture = picture
                    contentData.time = time
                    contentData.category?.category = category
                    appDelegate?.saveContext()
                    print("Content 데이터 저장")
                }
            }
        }
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기 (두번째 페이지에서 Material 저장)
    func saveMaterialData(content: Content?, materials: [Materials]) {
        for material in materials {
            guard let content = content, let context = content.managedObjectContext else { return }
            if let materialEntity = NSEntityDescription.entity(forEntityName: "Materials", in: context),
               let materialData = NSManagedObject(entity: materialEntity, insertInto: context) as? Materials {
                
                materialData.material = material.material
                materialData.unit = material.unit
                content.addToMaterials(materialData)
                
                do {
                    try context.save()
                    print("Material 데이터 저장 성공")
                } catch {
                    print("Material 데이터 저장 실패")
                }
            }
        }
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기 (세번째 페이지에서 Recipe 저장)
    func saveRecipeData(content: Content?, image: Data, description: String, timer: String) {
        guard let content = content, let context = content.managedObjectContext else { return }
        
        if let RecipeEntity = NSEntityDescription.entity(forEntityName: "Recipe", in: context),
           let RecipeData = NSManagedObject(entity: RecipeEntity, insertInto: context) as? Recipe {
            
            RecipeData.images = image
            RecipeData.descriptions = description
            RecipeData.timer = timer
            content.addToRecipe(RecipeData)
            
            do {
                try context.save()
                print("Recipe 데이터 저장 성공")
            } catch {
                print("Recipe 데이터 저장 실패")
            }
        }
    }
    
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기
    func deleteToDo(data: Content) {
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
                print("Content 데이터 삭제 성공")
            } catch {
                print("Content 데이터 삭제 실패")
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 Content 데이터 수정하기
    func updateContent(newData: Content) {
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
                print("Content 데이터 수정 성공")
            } catch {
                print("Content 데이터 수정 실패")
            }
        }
    }
    
    
    // MARK: - [Update] 코어데이터에서 Material 데이터 수정하기
    func updateMaterial(content: Content?, material: String, unit: String) {
        guard let content = content, let context = content.managedObjectContext else { return }
        
        context.perform {
            if let fetchedMaterialList = content.materials?.allObjects as? [Materials] {
                for targetMaterial in fetchedMaterialList {
                    targetMaterial.material = material
                    targetMaterial.unit = unit
                }
                
                do {
                    try context.save()
                    print("Material 데이터 수정 성공")
                } catch {
                    print("Material 데이터 수정 실패")
                }
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 Recipe 데이터 수정하기
    func updateRecipe(content: Content?, image: Data, description: String ,timer: String) {
        guard let content = content, let context = content.managedObjectContext else { return }
        
        context.perform {
            if let fetchedRecipeList = content.recipe?.allObjects as? [Recipe] {
                for targetRecipe in fetchedRecipeList {
                    targetRecipe.images = image
                    targetRecipe.descriptions = description
                    targetRecipe.timer = timer
                }
                
                do {
                    try context.save()
                    print("Material 데이터 수정 성공")
                } catch {
                    print("Material 데이터 수정 실패")
                }
            }
        }
    }
}
