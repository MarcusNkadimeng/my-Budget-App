//
//  CategoryTrackerRepository.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/16.
//

import Foundation

typealias CategoryResult = (Result<CategoryData, APIError>) -> Void

// MARK: - Repository Type Protocol
protocol CategoryTrackerRepositoryType: AnyObject {
    func fetchCategoryGroups(completion: @escaping CategoryResult)
}

// MARK: - Repository
class CategoryTrackerRepository: CategoryTrackerRepositoryType {
    func fetchCategoryGroups(completion: @escaping CategoryResult) {
        APIHandler.request(endpoint: URLConstants.categoryURL, method: .GET, completion: completion)
    }
}
