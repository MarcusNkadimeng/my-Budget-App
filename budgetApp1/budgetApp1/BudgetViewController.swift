//
//  ViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import UIKit

class BudgetViewController: UIViewController {
    
    private var viewModel: BudgetViewModel? {
        didSet {
            fillUI()
        }
    }
    
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = BudgetViewModel(repository: BudgetRepository(), delegate: self)
        viewModel?.getBudgets()
        // Do any additional setup after loading the view.
         
    }

    private func fillUI() {
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel, let budgetList = viewModel.budgetList, !budgetList.isEmpty else {
            return
        }
        budgetNameLabel.text = budgetList.first?.name
        startDateLabel.text = budgetList.first?.firstMonth
        endDateLabel.text = budgetList.first?.lastMonth
    }

}

// MARK: - ViewModel Delegate

extension BudgetViewController: ViewModelDelegate {
    
    func reloadView() {
        fillUI()
    }
    func show(error: String) {
        
    }
}

