//
//  AccountTransactionsViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/12.
//

import UIKit

class AccountTransactionsViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var accountNameLabel: UILabel!
    private lazy var viewModel = AccountTransactionsViewModel(repository: TransactionRepository(), delegate: self)
    var selectedAccount: Account?

    // MARK: - functions
    @IBAction private func segmentedChange(_ sender: UISegmentedControl) {
        viewModel.filterTransactions(segmentIndex: sender.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchTransactionsForAccount(accountID: selectedAccount?.id ?? "")
        setupTableView()
        setUpSegmentedControl()
        setUpAccountDetailsLayout()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionTableViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.TransactionViewCellIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 1.0, right: 0)
    }
    
    private func setUpSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Expenses", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Income", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderColor = UIColor.tertiary.cgColor
        segmentedControl.layer.borderWidth = 2.0
        var selectedSegmentAttributes: [NSAttributedString.Key: Any] = [:]
        selectedSegmentAttributes[.foregroundColor] = UIColor.white
        segmentedControl.setTitleTextAttributes(selectedSegmentAttributes, for: .selected)
    }
    
    private func setUpAccountDetailsLayout() {
        accountNameLabel.text = selectedAccount?.name
        accountNameLabel.textColor = UIColor.primary
    }
}

// MARK: - TableView Delegate
extension AccountTransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.transactionListCount
        case 1:
            return viewModel.expenses?.count ?? 0
        case 2:
            return viewModel.income?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.TransactionViewCellIdentifier) as? TransactionTableViewCell else { return UITableViewCell() }
        let transaction: Transaction?
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            transaction = viewModel.transaction(atIndex: indexPath.row)
        case 1:
            transaction = viewModel.expenses?[indexPath.row]
        case 2:
            transaction = viewModel.income?[indexPath.row]
        default:
            transaction = nil
        }
        if let transaction = transaction {
            cell.populateWith(transaction: transaction)
        }
        return cell
    }
}

// MARK: - ViewModel Delegate
extension AccountTransactionsViewController: AccountsTransactionViewModelDelegate {
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        print("Warning: \(AuthError.failedTofetchTransactions)")
    }
}
