//
//  AuthenticationRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/30.
//

import UIKit

protocol AuthenticationRepositoryType: AnyObject {
    func createUser(fullName: String, password: String, emailAddress: String, username: String)
    func loginUser(username: String, password: String) -> Bool
    func fetchAllUsers() -> Result<[UserEntity], Error>
}

class AuthenticationRepository: AuthenticationRepositoryType {
    
    // MARK: - Variables
    
    private var userSignedUp = false
    private let coreDataHandler = CoreDataHandler()
    
    // MARK: - Functions
    
    func fetchAllUsers() -> Result<[UserEntity], Error> {
        coreDataHandler.fetchAllUsers()
    }
    
    func createUser(fullName: String, password: String, emailAddress: String, username: String) {
        coreDataHandler.createUser(fullName: fullName, password: password, emailAddress: emailAddress, username: username)
    }
    
    func loginUser(username: String, password: String) -> Bool {
        var successfulLogin = false
        
        if !coreDataHandler.checkIfUserHasAccount(username: username, password: password) {
            print("Error fetching username: \(AuthError.failedToFetchUser)")
            successfulLogin = false
            return false
        } else {
            successfulLogin = true
        }
        return successfulLogin
    }
}
