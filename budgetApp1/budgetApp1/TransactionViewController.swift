//
//  TransactionViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import UIKit

class TransactionViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = TransactionViewModel(repository: TransactionRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getTransactions()

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionTableViewCell.nib(), forCellReuseIdentifier: TransactionTableViewCell.identifier)
    }

}

// MARK: - TableView Delegate
extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.TransactionListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier) as? TransactionTableViewCell else { return UITableViewCell() }
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
