//
//  TransactionTableViewCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var transactionNameLabel: UILabel!
    @IBOutlet private weak var transactionAmountLabel: UILabel!
    
    // MARK: - functions
    func populateWith(transaction: Transaction) {
        transactionNameLabel.text = transaction.categoryName
        transactionAmountLabel.text = String(Double(transaction.amount) / 1000.00)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib() -> UINib {
        UINib(nibName: "TransactionTableViewCell", bundle: nil)
    } 
}
