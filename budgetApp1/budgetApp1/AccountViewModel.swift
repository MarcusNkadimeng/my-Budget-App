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
 
    private var repository: AccountRepositoryType?
    private weak var delegate: AccountViewModelDelegate?
    var AccountList: [Account]?
//    var accData: AccountDataClass?
    
    init(repository: AccountRepositoryType, delegate: AccountViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var AccountListCount: Int {
        return AccountList?.count ?? 0
    }
    
    func account(atIndex: Int) -> Account? {
        return AccountList?[atIndex] ?? nil
    }
    
    func getAccounts() {
        repository?.getAccounts(completion: { [weak self] result in
            switch result {
            case .success(let response):
//                self?.accData = response.data
//                print(self?.accData)
                self?.AccountList = response.data.accounts
                self?.delegate?.reloadView()
                print(response.data.accounts)
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
                print(error.rawValue)
            }
        })
    }
}
