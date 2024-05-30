//
//  TransactionViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import UIKit

class TrackerViewController: UIViewController {
    
    // MARK: - variables
    private lazy var viewModel = CategoryTrackerViewModel(repository: CategoryTrackerRepository(), delegate: self)
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - functions
    override func viewDidLoad() {
        LoadingIndicator.showProgressView(on: self.view)
        viewModel.fetchCategoryGroups()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryHeaderTableViewCell.nib(), forHeaderFooterViewReuseIdentifier: NibIdentifiers.categoryGroupHeaderCellIdentifier)
        tableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.categoryViewCellIdentifier)
        tableView.register(CategoryFooterTableViewCell.nib(), forHeaderFooterViewReuseIdentifier: NibIdentifiers.categoryGroupFootCellIdentifier)
        tableView.allowsSelection = false
    }
}

// MARK: - TableView Delegate
extension TrackerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.categoryListCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NibIdentifiers.categoryGroupHeaderCellIdentifier) as? CategoryHeaderTableViewCell else {
            return nil
        }
        if let categoryGroup = viewModel.categoryGroup(atIndex: section),
           let totalBalance = viewModel.categoryGroupBalances[categoryGroup.name] {
            headerView.populateWith(categoryGroup: categoryGroup, totalBalance: totalBalance)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NibIdentifiers.categoryGroupFootCellIdentifier) as? CategoryFooterTableViewCell else {
            return nil
        }
        if let categoryGroup = viewModel.categoryGroup(atIndex: section),
           let total = viewModel.categoryGroupBalances[categoryGroup.name] {
            footerView.populateWith(totalBalance: total)
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.categoryViewCellIdentifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        if let category = viewModel.category(atIndexPath: indexPath) {
            cell.populateWith(category: category, balance: category.balance)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let categoryName = viewModel.categoryGroup(atIndex: section)?.name else {
            return 0
        }
        return viewModel.groupedCategories[categoryName]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
}

// MARK: - ViewModel Delegate
extension TrackerViewController: CategoryTrackerViewModelProtocol {
    func reloadView() {
        viewModel.groupCategories()
        LoadingIndicator.hideProgressView(from: self.view)
        tableView.reloadData()
    }
    
    func show(error: String) {
        showBasicAlert(title: "Error", message: "Failed to fetch categories")
    }
}
