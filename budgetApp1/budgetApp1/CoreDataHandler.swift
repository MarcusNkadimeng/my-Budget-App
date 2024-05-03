//
//  CoreDataHandler.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/02.
//

import CoreData
import UIKit

protocol CoreDataHandlerType {
    func createUser(fullName: String, password: String, emailAddress: String, username: String) -> Void
    func checkIfUserHasAccount(username: String) -> Bool
}

class CoreDataHandler: CoreDataHandlerType {
    
    weak var appDelegate: AppDelegate?
    let context: NSManagedObjectContext
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        self.appDelegate = appDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Public CRUD functions
    
    func checkIfUserHasAccount(username: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %d", username)
        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                print("User already exists with username: \(username)")
                return true
            } else {
                print("User profile does not exist. Create account.")
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func createUser(fullName: String, password: String, emailAddress: String, username: String) {
        if !checkIfUserHasAccount(username: username) {
            let user = UserEntity(context: context)
            user.username = username
            user.password = password
            user.fullName = fullName
            user.emailAddress = emailAddress
            saveContext()
        }   else {
            print("User with \(username) already exists")
        }
    }
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
