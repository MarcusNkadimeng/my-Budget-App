//
//  TrabnsactionsRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/15.
//

import Foundation

typealias TransactionResult = (Result<TransactionData, APIError>) -> Void

// MARK: - Repository Type
protocol TransactionRepositoryType: AnyObject {
    func getTransactions(completion: @escaping(TransactionResult))
    func fetchTransactionsForAccount(accountID: String, completion: @escaping(TransactionResult))
}

// MARK: - Repository
class TransactionRepository: TransactionRepositoryType {
    func getTransactions(completion: @escaping (TransactionResult)) {
        APIHandler.request(endpoint: URLConstants.transactionsURL, method: .GET, completion: completion)
    }
    
    func fetchTransactionsForAccount(accountID: String, completion: @escaping(TransactionResult)) {
        let accountTransactionsURL = "\(URLConstants.accountTransactionURL)\(accountID)/transactions/\(URLConstants.accessToken)"
        APIHandler.request(endpoint: accountTransactionsURL, method: .GET, completion: completion)
    }
}
