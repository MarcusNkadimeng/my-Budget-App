//
//  AccountTransactionsViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/12.
//

import UIKit

class AccountTransactionsViewController: UIViewController {

    // MARK: - UISpecs Dependency
    private let uiSpecs = UISpecs()
    
    // MARK: - Variables
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var accountNameLabel: UILabel!
    private lazy var viewModel = AccountTransactionsViewModel(repository: TransactionRepository(), delegate: self)
    var selectedAccount: Account?

    // MARK: - functions
    @IBAction func segmentedChange(_ sender: AnyObject) {
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
        segmentedControl.layer.borderColor = uiSpecs.primaryColourOne.cgColor
        segmentedControl.layer.borderWidth = 2.0
    }
    
    private func setUpAccountDetailsLayout() {
        accountNameLabel.text = selectedAccount?.name
        accountNameLabel.textColor = uiSpecs.primaryColourOne
    }
}

// MARK: - TableView Delegate
extension AccountTransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            viewModel.expenses?.count ?? 0
        } else {
            viewModel.income?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.TransactionViewCellIdentifier) as? TransactionTableViewCell else { return UITableViewCell() }
        if segmentedControl.selectedSegmentIndex == 0 {
            guard let transaction = viewModel.expenses?[indexPath.row] else { return UITableViewCell() }
            cell.populateWith(transaction: transaction)
        } else {
            guard let transaction = viewModel.income?[indexPath.row] else { return UITableViewCell() }
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
        
    }
}
