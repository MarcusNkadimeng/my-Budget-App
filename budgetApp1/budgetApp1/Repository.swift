//
//  BudgetRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

typealias BudgetsResult = (Result<BudgetData, APIError>) -> Void
typealias AccountResult = (Result<AccountData, APIError>) -> Void
typealias TransactionResult = (Result<TransactionData, APIError>) -> Void

protocol BudgetRepositoryType: AnyObject {
    func getBudgets(completion: @escaping(BudgetsResult))
}

protocol AccountRepositoryType: AnyObject {
    func getAccounts(completion: @escaping(AccountResult))
}

protocol TransactionRepositoryType: AnyObject {
    func getTransactions(completion: @escaping(TransactionResult))
    func fetchTransactionsForAccount(accountID: String, completion: @escaping(TransactionResult))
}

class BudgetRepository: BudgetRepositoryType {
    
    func getBudgets(completion: @escaping (BudgetsResult)) {
        APIHandler.request(endpoint: URLConstants.budgetURL, method: .GET, completion: completion)
    }
}

class AccountRepository: AccountRepositoryType {
    func getAccounts(completion: @escaping (AccountResult)) {
        APIHandler.request(endpoint: URLConstants.accountsURL, method: .GET, completion: completion)
    }
}

class TransactionRepository: TransactionRepositoryType {
    func getTransactions(completion: @escaping (TransactionResult)) {
        APIHandler.request(endpoint: URLConstants.transactionsURL, method: .GET, completion: completion)
    }
    
    func fetchTransactionsForAccount(accountID: String, completion: @escaping(TransactionResult)) {
        let accountTransactionsURL = "\(URLConstants.accountTransactionURL)\(accountID)/transactions/\(URLConstants.accessToken)"
        APIHandler.request(endpoint: accountTransactionsURL, method: .GET, completion: completion)
    }
}
