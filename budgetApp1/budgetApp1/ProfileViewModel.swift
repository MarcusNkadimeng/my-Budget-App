//
//  ProfileViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/29.
//

import Foundation

class ProfileViewModel {
    
    // MARK: - CoreData Dependency Injection
    private let coreDataHandler = CoreDataHandler()
    
    // MARK: - Functions
    func saveLoggedInUser(username: String) {
        coreDataHandler.saveLoggedInUser(username: username)
    }
    
    func fetchLoggedInUser() -> UserEntity? {
        coreDataHandler.fetchLoggedInUser()
    }
}
