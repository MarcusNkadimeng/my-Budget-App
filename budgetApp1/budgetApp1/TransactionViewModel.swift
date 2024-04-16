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
    private var delegate: TransactionViewModelDelegate?
    
    private var TransactionList: [Transaction]?
    
    init(repository: TransactionRepositoryType, delegate: TransactionViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var TransactionListCount: Int {
        return TransactionList?.count ?? 0
    }
    
    func transaction(atIndex: Int) -> Transaction?{
        return TransactionList?[atIndex] ?? nil
    }
    
    func getTransactions() {
        repository?.getTransactions(completion: {   [weak self] result in
            switch result {
            case .success(let response):
                self?.TransactionList = response.data.transactions
                self?.delegate?.reloadView()
                print(response.data.transactions)
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
                print(error.rawValue)
            }
        })
    }
}
