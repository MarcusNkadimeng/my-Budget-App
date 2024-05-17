//
//  CategoryTrackerViewModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/16.
//

import UIKit

protocol CategoryTrackerViewModelProtocol: AnyObject {
    func reloadView()
    func show(error: String)
}

class CategoryTrackerViewModel {
    
    // MARK: - Variables
    private var repository: CategoryTrackerRepositoryType?
    private weak var delegate: CategoryTrackerViewModelProtocol?
    private var categoryGroupList: [CategoryGroup]?
    
    init(repository: CategoryTrackerRepositoryType, delegate: CategoryTrackerViewModelProtocol) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var categoryListCount: Int {
        categoryGroupList?.count ?? 0
    }
    var groupedCategories: [String: [Category]] = [:]
    var categoryGroupBalances: [String: Int] = [:]
    
    // MARK: - Functions
    func categoryGroup(atIndex: Int) -> CategoryGroup? {
        categoryGroupList?[atIndex]
    }
    
    func fetchCategoryGroups() {
        repository?.fetchCategoryGroups { [weak self] result in
            switch result {
            case .success(let response):
                self?.categoryGroupList = response.data.categoryGroups
                print(self?.categoryGroupList)
                self?.delegate?.reloadView()
            case .failure(let error):
                self?.delegate?.show(error: error.rawValue)
            }
        }
    }
    
    func groupCategories() {
        groupedCategories.removeAll()
        categoryGroupBalances.removeAll()
        
        guard let categoryGroups = categoryGroupList else { return }
        
        for categoryGroup in categoryGroups {
            let categories = categoryGroup.categories
            for category in categories {
                groupedCategories[category.categoryGroupName, default: []].append(category)
                categoryGroupBalances[category.categoryGroupName, default: 0] += category.balance
            }
        }
    }
    
    func category(atIndexPath indexPath: IndexPath) -> Category? {
        guard let categoryGroup = categoryGroup(atIndex: indexPath.section),
              let categories = groupedCategories[categoryGroup.name],
              indexPath.row < categories.count else {
            return nil
        }
        return categories[indexPath.row]
    }
}
