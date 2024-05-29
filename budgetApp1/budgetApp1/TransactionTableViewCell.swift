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
        transactionNameLabel.text = transaction.memo
        transactionAmountLabel.text = String(format: "%.2f", Double(transaction.amount) / 1000.00)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let separatorHeight: CGFloat = 2.0
        
        for subview in self.subviews {
            if subview != contentView && subview.frame.height < 1 {
                subview.removeFromSuperview()
            }
        }
        
        let separatorView = UIView(frame: CGRect(x: 16, y: self.bounds.height - separatorHeight, width: self.bounds.width - 32, height: separatorHeight))
        separatorView.backgroundColor = UIColor.accent
        self.addSubview(separatorView)
        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    static func nib() -> UINib {
        UINib(nibName: "TransactionTableViewCell", bundle: nil)
    } 
}
