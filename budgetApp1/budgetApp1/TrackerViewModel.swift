//
//  TransactionViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import UIKit

protocol TrackerViewModelProtocol: AnyObject {
    func reloadView()
    func show(error: String)
}

// MARK: - View Model
class TrackerViewModel {
    
    // MARK: - Variables
    private var repository: TransactionRepositoryType?
    private weak var delegate: TrackerViewModelProtocol?
    private var transactionList: [Transaction]?

    init(repository: TransactionRepositoryType, delegate: TrackerViewModelProtocol) {
        self.repository = repository
        self.delegate = delegate
        fetchTransactions()
    }
    
    var transactionListCount: Int {
        transactionList?.count ?? 0
    }
    
    // MARK: - Functions
    func transaction(atIndex: Int) -> Transaction? {
        transactionList?[atIndex]
    }
    
    func fetchTransactions() {
        repository?.getTransactions {   [weak self] result in
            switch result {
            case .success(let response):
                self?.transactionList = response.data.transactions
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
