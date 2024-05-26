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
    
    // MARK: - Date Formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    private let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
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
        overviewViewModel.fetchBudgets()
        overviewViewModel.fetchAccounts()
        overviewViewModel.fetchTransactions()
        setupTableView()
    }

    private func updateView(withBudget budget: Budget) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        recentTransactionsLabel.text = UIComponents.recentTransactionLabel
        currentBalance.text = UIComponents.currentBalanceLabel
        currentBalanceLabel.text = String(format: "%.2f", (overviewViewModel.budgetTotal) / 1000)
        lastModified.text = UIComponents.lastModifiedLabel
        if let date = dateFormatter.date(from: budget.lastModifiedOn) {
            lastModifiedLabel.text = displayFormatter.string(from: date)
        } else {
            lastModifiedLabel.text = "Invalid Date"
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionTableViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.TransactionViewCellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = uiSpecs.tetiaryColour
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.TransactionViewCellIdentifier) as? TransactionTableViewCell else { return UITableViewCell() }
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
        tableView.reloadData()
    }
    
    func show(error: String) {
        print("Warning: \(AuthError.failedTofetchBudgets)")
    }
}
