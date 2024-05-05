//
//  Service Errors.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

// MARK: - Error enums

enum APIError: String, Error {
    case internalError
    case serverError
    case parsingError
}

enum AuthError: String, Error {
    case invalidCredentialsFailure
    case signUpFailure
    case failedTofetchUsername
    case failedTofetchPassword
    case failedTofetchUsers
    case failedToFetchUser
}
