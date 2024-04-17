//
//  AccountViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/03.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    private lazy var viewModel = AccountViewModel(repository: AccountRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getAccounts()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountViewCell.nib(), forCellReuseIdentifier: AccountViewCell.identifier)
    }
}

// MARK: - TableView Delegate

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.AccountListCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.identifier) as? AccountViewCell else { return UITableViewCell() }
        guard let account = viewModel.account(atIndex: indexPath.section) else { return UITableViewCell() }
        cell.populateWith(account: account)
        return cell
    }
}

// MARK: - ViewModel Delegate

extension AccountViewController: AccountViewModelDelegate {
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
//        displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
