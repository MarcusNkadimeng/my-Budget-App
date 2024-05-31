//
//  AccountViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/03.
//

import UIKit

class AccountViewController: UIViewController {

    // MARK: - variables
    @IBOutlet private var tableView: UITableView!
    private lazy var viewModel = AccountViewModel(repository: AccountRepository(), delegate: self)
    
    // MARK: - functions
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.showProgressView(on: self.view)
        setupTableView()
        viewModel.fetchAccounts()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.accountViewCellIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

// MARK: - TableView Delegate
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.accountListCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.accountViewCellIdentifier) as? AccountViewCell,
              let account = viewModel.account(atIndex: indexPath.row) else { return UITableViewCell() }
        cell.populateWith(account: account)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedAccount = viewModel.account(atIndex: indexPath.row) else {
            return
        }
        performSegue(withIdentifier: Segues.accountTransactionsSegue, sender: selectedAccount)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.accountTransactionsSegue,
           let selectedIndexPath = tableView.indexPathForSelectedRow,
           let accountTransactionsViewController = segue.destination as? AccountTransactionsViewController {
            let selectedAccount = viewModel.account(atIndex: selectedIndexPath.row)
            accountTransactionsViewController.selectedAccount = selectedAccount
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

// MARK: - ViewModel Delegate

extension AccountViewController: AccountViewModelDelegate {
    func reloadView() {
        LoadingIndicator.hideProgressView(from: self.view)
        tableView.reloadData()
    }
    
    func show(error: String) {
        showBasicAlert(title: "Error", message: "Failed to fetch accounts")
    }
}
