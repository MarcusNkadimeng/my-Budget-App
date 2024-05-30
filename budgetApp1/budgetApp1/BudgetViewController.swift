//
//  ViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import UIKit

class BudgetViewController: UIViewController {
    
    // MARK: - Date Formatter
//    private let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        return formatter
//    }()
//
//    private let displayFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter
//    }()
    let dateFormatter = DataFormatterClass()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var recentTransactionsLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var budgetCardTableView: UITableView!
    @IBOutlet private weak var currentBalance: UILabel!
    @IBOutlet private weak var currentBalanceLabel: UILabel!
    @IBOutlet private weak var lastModified: UILabel!
    @IBOutlet private weak var lastModifiedLabel: UILabel!
    
    // MARK: - ViewModel
    private lazy var overviewViewModel = OverviewViewModel(repository: BudgetRepository(), repositoryTwo: AccountRepository(), repositoryThree: TransactionRepository(), delegate: self)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.showProgressView(on: self.view)
        setUpScreen()
    }

    private func updateView(withBudget budget: Budget) {
        recentTransactionsLabel.text = UIComponents.recentTransactionLabel
        currentBalance.text = UIComponents.currentBalanceLabel
        currentBalanceLabel.text = String(format: "%.2f", (overviewViewModel.budgetTotal) / 1000)
        lastModified.text = UIComponents.lastModifiedLabel
        let originalDateString = budget.lastModifiedOn
        if let formattedDate = dateFormatter.formatDateString(originalDateString) {
            lastModifiedLabel.text = formattedDate
        } else {
            lastModifiedLabel.text = "Invalid Date"
        }
    }
    
    private func setUpScreen() {
        setupTableView()
        overviewViewModel.fetchBudgets()
        overviewViewModel.fetchAccounts()
        overviewViewModel.fetchTransactions()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionTableViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.transactionViewCellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.accent
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        tableView.allowsSelection = false
    }
}

extension BudgetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        overviewViewModel.transactionListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.transactionViewCellIdentifier) as? TransactionTableViewCell else { return UITableViewCell() }
        guard let transaction = overviewViewModel.transaction(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateWith(transaction: transaction)
        return cell
    }
}

// MARK: - ViewModel Delegate
extension BudgetViewController: ViewModelDelegate, AccountsTransactionViewModelDelegate {
    
    func reloadView() {
        guard let budget = overviewViewModel.budgetList?.first else { return }
        updateView(withBudget: budget)
        LoadingIndicator.hideProgressView(from: self.view)
        tableView.reloadData()
    }
    
    func show(error: String) {
        showBasicAlert(title: "Error", message: "Failed to fetch budgets")
    }
}
