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
    
    static func saveData(_ product: IECart) {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(
            forEntityName: "IECart", in: context
        ) else { return }
        
        let object = IECart(entity: entity, insertInto: context)
        object.id = product.id
        object.product = product.product
        object.selectedColor = product.selectedColor
        object.cartQuantity = product.cartQuantity
        
        do {
            try context.save()
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
    
    static func fetchData() -> [IECart] {
        guard let context = context else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "IECart")
        
        do {
            guard let ieCartList = try context.fetch(fetchRequest) as? [IECart] else {
                return []
            }
            
            return ieCartList
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
            return []
        }
    }
    
    static func updateData(_ product: IECart) {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "IECart")
        guard let idStr = product.id?.uuidString else { return }
        fetchRequest.predicate = NSPredicate(format: "id = %@", idStr)
        
        do {
            guard let result = try? context.fetch(fetchRequest),
                  let object = result.first as? IECart else { return }
            
            object.selectedColor = product.selectedColor
            object.cartQuantity = product.cartQuantity
            
            try context.save()
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
    
    static func deleteData(uuid: UUID) {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "IECart")
        fetchRequest.predicate = NSPredicate(format: "id = %@", uuid.uuidString)
        
        do {
            guard let result = try? context.fetch(fetchRequest),
                  let object = result.first as? IECart else { return }
            
            context.delete(object)
            
            try context.save()
            
        } catch {
            let msg = error.localizedDescription
            os_log("error: %@", log: log, type: .error, msg)
        }
    }
}


