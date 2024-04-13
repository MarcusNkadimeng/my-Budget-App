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
}

class BudgetRepository: BudgetRepositoryType {
    
    func getBudgets(completion: @escaping (BudgetsResult)) {
        APIHandler.request(endpoint: "https://api.ynab.com/v1/budgets?access_token=t_Ikm7Q2U94be-lmSn4blgh1sjIEf1dMF7Tv8jguvpU", method: .GET, completion: completion)
    }
}

class AccountRepository: AccountRepositoryType {
    func getAccounts(completion: @escaping (AccountResult)) {
        APIHandler.request(endpoint: "https://api.ynab.com/v1/budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts?access_token=t_Ikm7Q2U94be-lmSn4blgh1sjIEf1dMF7Tv8jguvpU", method: .GET, completion: completion)
    }
}

class TransactionRepository: TransactionRepositoryType {
    func getTransactions(completion: @escaping (TransactionResult)) {
        APIHandler.request(endpoint: "https://api.ynab.com/v1/budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts/0515719a-f641-422b-8341-7073d5358dbe/transactions?access_token=t_Ikm7Q2U94be-lmSn4blgh1sjIEf1dMF7Tv8jguvpU", method: .GET, completion: completion)
    }
}
