//
//  AccountTransactionsViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/12.
//

import Foundation

protocol AccountsTransactionViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

// MARK: - View Model
class AccountTransactionsViewModel {
    
    // MARK: - Variables
    private var repository: TransactionRepositoryType?
    private weak var delegate: AccountsTransactionViewModelDelegate?
    private var transactionList: [Transaction]?
    var expenses: [Transaction]?
    var income: [Transaction]?
    
    init(repository: TransactionRepositoryType, delegate: AccountsTransactionViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func fetchTransactionsForAccount(accountID: String) {
        repository?.fetchTransactionsForAccount(accountID: accountID) { [weak self] result in
            switch result {
            case .success(let transactionData):
                self?.transactionList = transactionData.data.transactions
                self?.filterTransactions(segmentIndex: 0)
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func filterTransactions(segmentIndex: Int) {
        guard let transactions = transactionList else { return }
        if segmentIndex == 0 {
            expenses = transactions.filter { $0.amount < 0 }
            income = transactions.filter { $0.amount >= 0 }
        } else {
            income = transactions.filter { $0.amount >= 0 }
            expenses = transactions.filter { $0.amount < 0 }
        }
        delegate?.reloadView()
    }
}
