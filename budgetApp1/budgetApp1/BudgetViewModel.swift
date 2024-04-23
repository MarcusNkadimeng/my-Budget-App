//
//  BudgetViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}

class BudgetViewModel {
    
    private var repository: BudgetRepositoryType?
    private weak var delegate: ViewModelDelegate?
    var budgetList: [Budget]? {
        didSet {
            delegate?.reloadView()
        }
    }
    
    init(repository: BudgetRepositoryType, delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var budgetListCount: Int {
        budgetList?.count ?? 0
    }
    
    func budget(atIndex: Int) -> Budget? {
        budgetList?[atIndex]
    }
    
    func fetchBudgets() {
        repository?.getBudgets(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.budgetList = response.data.budgets
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}
