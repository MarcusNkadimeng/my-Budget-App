//
//  Service Errors.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

enum APIError: String, Error {
    case internalError
    case serverError
    case parsingError
}

enum Method {
    case GET
    case POST
}
