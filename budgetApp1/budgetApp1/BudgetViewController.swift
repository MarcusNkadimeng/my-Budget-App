//
//  ViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import UIKit

class BudgetViewController: UIViewController {
    
    // MARK: - UISpecs Dependency
    private let uiSpecs = UISpecs()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var budgetNameLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var recentTransactionsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var budgetViewModel = BudgetViewModel(repository: BudgetRepository(), delegate: self)
    private lazy var transactionViewModel = AccountTransactionsViewModel(repository: TransactionRepository(), delegate: self)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetViewModel.fetchBudgets()
        transactionViewModel.fetchTransactions()
        setupTableView()
    }

    private func updateView(withBudget budget: Budget) {
        budgetNameLabel.text = budget.name
        startDateLabel.text = budget.firstMonth
        endDateLabel.text = budget.lastMonth
        toDateLabel.text = "–"
        recentTransactionsLabel.text = "Most recent transactions"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionTableViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.TransactionViewCellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = uiSpecs.primaryColourOne
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension BudgetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionViewModel.transactionListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.TransactionViewCellIdentifier) as? TransactionTableViewCell else { return UITableViewCell() }
        guard let transaction = transactionViewModel.transaction(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateWith(transaction: transaction)
        return cell
    }
}

// MARK: - ViewModel Delegate
extension BudgetViewController: ViewModelDelegate, AccountsTransactionViewModelDelegate {
    
    func reloadView() {
        guard let budget = budgetViewModel.budgetList?.first else { return }
        updateView(withBudget: budget)
        
        tableView.reloadData()
    }
    
    func show(error: String) {
    }
}
