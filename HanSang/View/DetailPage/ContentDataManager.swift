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
    
    // MARK: - [Create] 코어데이터에 카테고리 생성하기
    func saveCategory(categoryName: String) -> Category? {
        if let context = context,
           let entity = NSEntityDescription.entity(forEntityName: "Category", in: context),
           let categoryData = NSManagedObject(entity: entity, insertInto: context) as? Category {
            categoryData.id = UUID()
            categoryData.category = categoryName
            appDelegate?.saveContext()
            print("카테고리 데이터 저장 성공")
            return categoryData
        } else {
            return nil
        }
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기 (첫번째 페이지에서 Content저장)
    func saveContentData(content: RecipeInfoModel) -> Content? {
        if let context = context,
           let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context),
           let contentData = NSManagedObject(entity: entity, insertInto: context) as? Content,
           let imageData = content.image.jpegData(compressionQuality: 1.0) {
            contentData.id = UUID()
            contentData.date = content.date
            contentData.title = content.title
            contentData.difficulty = content.difficulty
            contentData.kick = content.kick
            contentData.picture = imageData
            contentData.time = content.time
            
            let categoryName = content.category
            if let category = saveCategory(categoryName: categoryName) {
                contentData.category = category
            }
            
            appDelegate?.saveContext()
            print("Content 데이터 저장")
            
            return contentData
        } else {
            return nil
        }
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기 (두번째 페이지에서 Material 저장)
    func saveMaterialData(content: Content, materials: [MaterialModel]) {
        guard let context = context else { return }
        
        for material in materials {
            if let materialEntity = NSEntityDescription.entity(forEntityName: "Materials", in: context),
               let materialData = NSManagedObject(entity: materialEntity, insertInto: context) as? Materials {
                materialData.material = material.material
                materialData.unit = material.unit
                content.addToMaterials(materialData)
            }
        }
        
        do {
            try context.save()
            print("Material 데이터 저장 성공")
        } catch {
            print("Material 데이터 저장 실패")
        }
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기 (세번째 페이지에서 Recipe 저장)
    func saveRecipeData(content: Content, recipes: [RecipeModel]) {
        guard let context = context else { return }
        
        for recipe in recipes {
            if let recipeEntity = NSEntityDescription.entity(forEntityName: "Recipe", in: context),
               let recipeData = NSManagedObject(entity: recipeEntity, insertInto: context) as? Recipe {
                recipeData.descriptions = recipe.descriptions
                recipeData.images = recipe.image?.jpegData(compressionQuality: 1.0)
                recipeData.timer = recipe.timer
                content.addToRecipe(recipeData)
            }
        }
        
        do {
            try context.save()
            print("Recipe 데이터 저장 성공")
        } catch {
            print("Recipe 데이터 저장 실패")
        }
    }
    // 🧨 수정
    func saveRecipe(content: RecipeInfoModel, materials: [MaterialModel], recipes: [RecipeModel], user: User) {
        guard let contentData = saveContentData(content: content) else { return }
        contentData.user = user
        saveMaterialData(content: contentData, materials: materials)
        saveRecipeData(content: contentData, recipes: recipes)
        //테스트 코드
        if let test = ContentDataManager.shared.getContentListFromCoreData().first {
            if let title = test.title,
               let category = test.category?.category,
               let time = test.time,
               let difficulty = test.difficulty,
               let materials = test.materials?.allObjects as? [Materials],
               let recipes = test.recipe?.allObjects as? [Recipe] {
                var materialsString = ""
                for material in materials {
                    if let materialName = material.material, let unit = material.unit {
                        materialsString.append("\(materialName) (\(unit)), ")
                    }
                }
                if !materialsString.isEmpty {
                    materialsString.removeLast(2) // 마지막 ", " 제거
                }
                
                var recipesString = ""
                for recipe in recipes {
                    if let description = recipe.descriptions, let timer = recipe.timer {
                        recipesString.append("\(description) (\(timer)), ")
                    }
                }
                if !recipesString.isEmpty {
                    recipesString.removeLast(2) // 마지막 ", " 제거
                }
                
                print("""
                      ===========================
                      요리명: \(title)
                      카테고리: \(category)
                      소요시간: \(time)
                      난이도: \(difficulty)
                      재료: \(materialsString)
                      요리순서: \(recipesString)
                      ===========================
                      """)
            }
        } else {
            print("저장된 Content 데이터가 없습니다.")
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
    
    // MARK: - 북마크 설정 및 데이터 얻기
    func toggleBookmark(content: Content) {
        content.bookmark = !content.bookmark
        
        do {
            try context?.save()
            print("북마크 업데이트 성공")
        } catch {
            print("북마크 업데이트 실패: \(error.localizedDescription)")
        }
    }
    
    func getContentBookmark() -> [Content] {
        return self.getContentListFromCoreData().filter { $0.bookmark == true }
    }
    
    func selectedCategoryContentList(category: String) -> [Content] {
        return self.getContentListFromCoreData().filter { $0.category?.category == category }
    }
    
    func getCategoryContents(category: String) -> [Content]? {
        let request = NSFetchRequest<Content>(entityName: "Content")
        request.predicate = NSPredicate(format: "category.category == %@", category)

        do {
            let contents = try context?.fetch(request)
            return contents
        } catch {
            print("🚨 카테고리 정보 찾을 수 없음: \(error)")
            return nil
        }
    }
}
