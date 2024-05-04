//
//  AuthenticationRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/30.
//

import UIKit

protocol AuthenticationRepositoryType: AnyObject {
    func fetchUsername(username: String, completion: @escaping (Result<[UserEntity], Error>) -> Void)
    func fetchPassword(password: String, completion: @escaping (Result<[UserEntity], Error>) -> Void)
    func createUser(fullName: String, password: String, emailAddress: String, username: String)
    func loginUser(username: String, password: String) -> Bool
}

class AuthenticationRepository: AuthenticationRepositoryType {
    
    // MARK: - Variables
    
    private var userData: [UserEntity] = []
    private var userSignedUp = false
    private let coreDataHandler = CoreDataHandler()
    
    // MARK: - Functions
    
    func fetchUsername(username: String, completion: @escaping (Result<[UserEntity], Error>) -> Void) {
        coreDataHandler.fetchUsername(username: username, completion: completion)
    }
    
    func fetchPassword(password: String, completion: @escaping (Result<[UserEntity], Error>) -> Void) {
        coreDataHandler.fetchPassword(password: password, completion: completion)
    }
    
    func createUser(fullName: String, password: String, emailAddress: String, username: String) {
        coreDataHandler.createUser(fullName: fullName, password: password, emailAddress: emailAddress, username: username)
    }
    
    func loginUser(username: String, password: String) -> Bool {
        if !coreDataHandler.checkIfUserHasAccount(username: username) {
            return false
        }
        
        var successfulLogin = false
        
        fetchUsername(username: username) { result in
            switch result {
            case .success(let users):
                guard let user = users.first(where: { $0.username == username }) else {
                    return
                }
                if user.password == password {
                    successfulLogin = true
                } else {
                    successfulLogin = false
                }
            case .failure(let error):
                print("Error fetching username: \(error)")
            }
        }
        return successfulLogin
    }
}
