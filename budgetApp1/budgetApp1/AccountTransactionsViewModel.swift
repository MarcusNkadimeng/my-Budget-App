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
    var allTransactions: [Transaction]?
    
    init(repository: TransactionRepositoryType, delegate: AccountsTransactionViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var transactionListCount: Int {
        transactionList?.count ?? 0
    }
    
    // MARK: - Functions
    
    func transaction(atIndex: Int) -> Transaction? {
        transactionList?[atIndex]
    }
    
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
    
    func fetchTransactions() {
        repository?.fetchTransactions { [weak self] result in
            switch result {
            case .success(let transactionData):
                self?.transactionList = Array(transactionData.data.transactions.prefix(5))
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func filterTransactions(segmentIndex: Int) {
        guard let transactions = transactionList else { return }
        switch segmentIndex {
        case 0:
            expenses = transactions.filter { $0.amount < 0 }
            income = transactions.filter { $0.amount >= 0 }
        case 1:
            expenses = transactions.filter { $0.amount < 0 }
        case 2:
            income = transactions.filter { $0.amount >= 0 }
        default:
            break
        }
        delegate?.reloadView()
    }
}
