//
//  OverviewViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/25.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class OverviewViewModel {
    
    // MARK: - Computed variables
    var budgetListCount: Int {
        budgetList?.count ?? 0
    }
    
    var accountListCount: Int {
        accountList?.count ?? 0
    }
    
    var transactionListCount: Int {
        transactionList?.count ?? 0
    }
    
    // MARK: - Variables
    var budgetList: [Budget]?
    var budgetTotal = 0.00
    private var repository: BudgetRepositoryType?
    private var repositoryTwo: AccountRepositoryType?
    private var repositoryThree: TransactionRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var accountList: [Account]?
    private var transactionList: [Transaction]?
    
    init(repository: BudgetRepositoryType, repositoryTwo: AccountRepositoryType, repositoryThree: TransactionRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.repositoryTwo = repositoryTwo
        self.repositoryThree = repositoryThree
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func account(atIndex: Int) -> Account? {
        accountList?[atIndex]
    }
    
    func budget(atIndex: Int) -> Budget? {
        budgetList?[atIndex]
    }
    
    func transaction(atIndex: Int) -> Transaction? {
        transactionList?[atIndex]
    }
    
    func fetchBudgets() {
        repository?.fetchBudgets { [weak self] result in
            switch result {
            case .success(let response):
                self?.budgetList = response.data.budgets
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func fetchAccounts() {
        repositoryTwo?.fetchAccounts { [weak self] result in
            switch result {
            case .success(let response):
                self?.accountList = response.data.accounts
                self?.accumulateBudgetTotal()
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func fetchTransactions() {
        repositoryThree?.fetchTransactions { [weak self] result in
            switch result {
            case .success(let transactionData):
                self?.transactionList = Array(transactionData.data.transactions.prefix(5))
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func accumulateBudgetTotal() {
        guard let budgetAccounts = accountList else { return }
        budgetTotal = budgetAccounts.reduce(0.0) { $0 + Double($1.balance) }
    }
}
