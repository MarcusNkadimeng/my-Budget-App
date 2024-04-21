//
//  TransactionTableViewCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    
    static let identifier = "TransactionTableViewCell"
    
    func populateWith(transaction: Transaction) {
        transactionNameLabel.text = transaction.categoryName
        transactionAmountLabel.text = String(Double(transaction.amount) / 1000.00)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: "TransactionTableViewCell", bundle: nil)
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
