//
//  CoreDataManager.swift
//  TeamProject
//
//  Created by 서동환 on 4/9/25.
//

import UIKit
import CoreData
import OSLog

final class CoreDataManager {
    private static let log = OSLog(subsystem: "com.nbcampMasterChapter3Team4.TeamProject", category: "CoreDataManager")
    
    // MARK: - Core Data
    
    private static let context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            os_log("AppDelegate가 초기화되지 않았습니다.", log: log, type: .error)
            
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    /// IECartModel을 매개변수로 받아 IECart로 변환 후 CoreData에 저장합니다.
    static func saveData(_ ieCartModel: IECartModel) {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(
            forEntityName: "IECart", in: context
        ) else { return }
        
        let object = IECart(entity: entity, insertInto: context)
        object.id = ieCartModel.id
        object.productID = Int64(ieCartModel.productID)
        object.selectedColor = ieCartModel.selectedColor.rawValue
        object.cartQuantity = Int64(ieCartModel.cartQuantity)
        
        do {
            try context.save()
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
    
    /// Core Data에 저장되어있는 IECart 데이터들을 IECartModel 배열로 변환 후 반환합니다.
    static func fetchData() -> [IECartModel] {
        guard let context = context else { return [] }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "IECart")
        
        do {
            guard let ieCartList = try context.fetch(fetchRequest) as? [IECart] else {
                return []
            }
            
            var ieCartModelList = [IECartModel]()
            for ieCart in ieCartList {
                guard let id = ieCart.id,
                      let selectedColorStr = ieCart.selectedColor,
                      let selectedColor = IEColor(rawValue: selectedColorStr) else { continue }
                
                let data = IECartModel(
                    id: id,
                    productID: Int(ieCart.productID),
                    selectedColor: selectedColor,
                    cartQuantity: Int(ieCart.cartQuantity)
                )
                ieCartModelList.append(data)
            }
            return ieCartModelList
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
            return []
        }
    }
    
    /// IECartModel을 매개변수로 받아 CoreData에서 해당하는 UUID의 데이터를 수정합니다.(미사용)
    static func updateData(_ ieCartModel: IECartModel) {
        guard let context = context else { return }
        
        do {
            if let object = fetchEntity(id: ieCartModel.id) {
                object.selectedColor = ieCartModel.selectedColor.rawValue
                object.cartQuantity = Int64(ieCartModel.cartQuantity)
            }
            try context.save()
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
    
    /// IECartModel의 UUID를 매개변수로 받아 CoreData에서 해당하는 데이터의 quantity를 수정합니다.
    static func updateQuantityData(_ ieCartModelID: UUID, _ quantity: Int) {
        guard let context = context else { return }
        
        do {
            if let object = fetchEntity(id: ieCartModelID) {
                object.cartQuantity = Int64(quantity)
            }
            try context.save()
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
    
    /// IEProduct의 id를 매개변수로 받아 CoreData에서 해당하는 데이터의 quantity를 수정합니다.
    static func updateQuantityAlreadyExist(productID: Int, selectedColor: IEColor, quantity: Int) -> Bool {
        guard let context = context else { return false }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "IECart")
        fetchRequest.predicate = NSPredicate(format: "productID = %d AND selectedColor = %@", productID, selectedColor.rawValue)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let object = result.first as? IECart {
                object.selectedColor = selectedColor.rawValue
                object.cartQuantity = Int64(quantity)
                try context.save()
                return true
            } else {
                return false
            }
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
            return false
        }
    }
    
    /// UUID를 매개변수로 받아 CoreData에서 해당하는 UUID의 데이터를 삭제합니다.
    static func deleteData(id: UUID) {
        guard let context = context else { return }
        
        do {
            if let object = fetchEntity(id: id) {
                context.delete(object)
                try context.save()
            }
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
    
    static func deleteAllData() {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "IECart")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            print("✅ coredata 삭제 완료")
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
    
    static func fetchEntity(id: UUID) -> IECart? {
        guard let context = context else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "IECart")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first as? IECart
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
            
            return nil
        }
    }
}


