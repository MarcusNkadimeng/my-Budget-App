//
//  TransactionViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import UIKit

class TransactionViewController: UIViewController {

    // MARK: - UISpecs Dependency
    private let uiSpecs = UISpecs()
    
    // MARK: - variables
    @IBOutlet weak var tableView: UITableView!
    private lazy var viewModel = TransactionViewModel(repository: TransactionRepository(), delegate: self)
    
    // MARK: - functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionTableViewCell.nib(), forCellReuseIdentifier: NibIdentifiers.TransactionViewCellIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 1.0, right: 0)
        tableView.layer.borderWidth = 2.0
        tableView.layer.borderColor = uiSpecs.primaryColourOne.cgColor
        viewModel.fetchTransactions()
    }
}

// MARK: - TableView Delegate
extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transactionListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibIdentifiers.TransactionViewCellIdentifier) as? TransactionTableViewCell else { return UITableViewCell() }
        guard let transaction = viewModel.transaction(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateWith(transaction: transaction)
        return cell
    }
}

// MARK: - ViewModel Delegate
extension TransactionViewController: TransactionViewModelDelegate {
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        
    }
}
