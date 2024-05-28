//
//  AuthenticationRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/30.
//

import UIKit

protocol AuthenticationRepositoryType: AnyObject {
    func createUser(password: String, username: String) -> Bool
    func loginUser(username: String, password: String) -> Bool
}

class AuthenticationRepository: AuthenticationRepositoryType {
    
    // MARK: - Variables
    private let coreDataHandler = CoreDataHandler()
    
    // MARK: - Functions
    func createUser(password: String, username: String) -> Bool {
        coreDataHandler.createUser(password: password, username: username)
    }
    
    func loginUser(username: String, password: String) -> Bool {
        if !coreDataHandler.checkIfUserHasAccount(username: username, password: password) {
            return false
        } else {
            return true
        }
    }
}
