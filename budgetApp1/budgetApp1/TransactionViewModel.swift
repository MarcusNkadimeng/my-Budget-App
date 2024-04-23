//
//  TransactionViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import Foundation

protocol TransactionViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class TransactionViewModel {
    
    private var repository: TransactionRepositoryType?
    private weak var delegate: TransactionViewModelDelegate?
    
    private var transactionList: [Transaction]?
    
    init(repository: TransactionRepositoryType, delegate: TransactionViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var transactionListCount: Int {
        transactionList?.count ?? 0
    }
    
    func transaction(atIndex: Int) -> Transaction? {
        transactionList?[atIndex]
    }
    
    func fetchTransactions() {
        repository?.getTransactions(completion: {   [weak self] result in
            switch result {
            case .success(let response):
                self?.transactionList = response.data.transactions
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
