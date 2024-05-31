//
//  AccountViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/03.
//

import Foundation

protocol AccountViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class AccountViewModel {
 
    // MARK: - Variables
    private var repository: AccountRepositoryType?
    private weak var delegate: AccountViewModelDelegate?
    private var accountList: [Account]?
    
    init(repository: AccountRepositoryType, delegate: AccountViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var accountListCount: Int {
        accountList?.count ?? 0
    }
    
    // MARK: - Functions
    func account(atIndex: Int) -> Account? {
        accountList?[atIndex]
    }
    
    func fetchAccounts() {
        repository?.fetchAccounts { [weak self] result in
            switch result {
            case .success(let response):
                self?.accountList = response.data.accounts
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
}
