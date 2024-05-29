//
//  UserModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import Foundation

// MARK: User dataclass

struct User {
    var password: String
    var username: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
