//
//  AuthenticationRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/30.
//

import Foundation
import UIKit

typealias Username = (Result<String, AuthError>) -> Void
typealias Password = (Result<String, AuthError>) -> Void
typealias SignUpResult = (Result<Bool, AuthError>) -> Void

protocol AuthenticationRepositoryType: AnyObject {
    func fetchUsername(username: String)
    func fetchPassword(password: String)
    func createUser(fullName: String, password: String, emailAddress: String, username: String)
    func loginUser(username: String, password: String) -> Bool
}

class AuthenticationRepository: AuthenticationRepositoryType {
    
    // MARK: - Variables
    
    private var userData: [UserEntity] = []
    private var userSignedUp = false
    private let coreDataHandler = CoreDataHandler()
    
    // MARK: - Functions
    
    func fetchUsername(username: String) {
        do {
            try userData = coreDataHandler.context.fetch(UserEntity.fetchRequest())
        } catch {
            print("Error fetching username: \(AuthError.failedTofetchUsername)")
        }
    }
    
    func fetchPassword(password: String) {
        do {
            try userData = coreDataHandler.context.fetch(UserEntity.fetchRequest())
        } catch {
            print("Error fetching password: \(AuthError.failedTofetchUsername)")
        }
    }
    
    func createUser(fullName: String, password: String, emailAddress: String, username: String) {
        coreDataHandler.createUser(fullName: fullName, password: password, emailAddress: emailAddress, username: username)
    }
    
    func loginUser(username: String, password: String) -> Bool {
        if !coreDataHandler.checkIfUserHasAccount(username: username) {
            print("User account does not exist. Please create account.")
        }
        fetchUsername(username: username)
        guard let user = userData.first(where: { $0.username == username })
        else {
            print("Error: User data not found for username: \(username)")
                    return false
        }
        
        if user.password == password {
            print("Login successful with user: \(username) and \(password)")
            return true
        } else {
            print("Incorrect password")
            return false
        }
    }
}
