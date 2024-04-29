//
//  ViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import UIKit

class BudgetViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var budgetNameLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    
    private lazy var viewModel = BudgetViewModel(repository: BudgetRepository(), delegate: self)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchBudgets()
    }

    private func updateView(withBudget budget: Budget) {
        budgetNameLabel.text = budget.name
        startDateLabel.text = budget.firstMonth
        endDateLabel.text = budget.lastMonth
    }
}

// MARK: - ViewModel Delegate
extension BudgetViewController: ViewModelDelegate {
    
    func reloadView() {
        guard let budget = viewModel.budgetList?.first else { return }
        updateView(withBudget: budget)
    }
    
    func show(error: String) {
    }
}
