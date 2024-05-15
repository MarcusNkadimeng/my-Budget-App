//
//  BudgetRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/15.
//

import Foundation

typealias BudgetsResult = (Result<BudgetData, APIError>) -> Void

// MARK: - Repository Type
protocol BudgetRepositoryType: AnyObject {
    func fetchBudgets(completion: @escaping(BudgetsResult))
}

// MARK: - Repository
class BudgetRepository: BudgetRepositoryType {
    func fetchBudgets(completion: @escaping (BudgetsResult)) {
        APIHandler.request(endpoint: URLConstants.budgetURL, method: .GET, completion: completion)
    }
}
