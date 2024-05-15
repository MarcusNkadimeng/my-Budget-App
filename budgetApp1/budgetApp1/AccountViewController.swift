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
    @IBOutlet private weak var accountHeaderLabel: UILabel!
    private lazy var viewModel = AccountViewModel(repository: AccountRepository(), delegate: self)
    
    // MARK: - UISpecs Dependency
    private let uiSpecs = UISpecs()
    
    // MARK: - functions
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.accountViewCellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountHeaderLabel.text = UIComponents.accountScreenHeader
        setupTableView()
        viewModel.fetchAccounts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
}

// MARK: - TableView Delegate
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.accountListCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.accountViewCellIdentifier) as? AccountViewCell else { return UITableViewCell() }
        guard let account = viewModel.account(atIndex: indexPath.row) else { return UITableViewCell() }
        cell.populateWith(account: account)
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
        }
    }
}

// MARK: - ViewModel Delegate

extension AccountViewController: AccountViewModelDelegate {
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        print("Warning: \(AuthError.failedTofetchAccounts)")
    }
}
