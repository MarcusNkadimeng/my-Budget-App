//
//  TransactionTableViewCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var TransactionNameLabel: UILabel!
    @IBOutlet weak var TransactionAmountLabel: UILabel!
    
    static let identifier = "TransactionTableViewCell"
    
    func populateWith(transaction: Transaction){
        TransactionNameLabel.text = transaction.categoryName
        TransactionAmountLabel.text = String(transaction.amount)
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
