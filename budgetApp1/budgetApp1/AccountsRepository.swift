//
//  BudgetRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

typealias AccountResult = (Result<AccountData, APIError>) -> Void

// MARK: - Repository Type
protocol AccountRepositoryType: AnyObject {
    func fetchAccounts(completion: @escaping AccountResult)
}

// MARK: - Repository
class AccountRepository: AccountRepositoryType {
    
    func fetchAccounts(completion: @escaping AccountResult) {
        APIHandler.request(endpoint: URLConstants.accountsURL, method: .GET, completion: completion)
    }
}
