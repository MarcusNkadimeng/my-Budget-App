//
//  AccountCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/04.
//

import UIKit

class AccountViewCell: UITableViewCell {
    
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    static let identifier = "AccountViewCell"
    
    func populateWith(account: Account){
        accountNameLabel.text = account.name
        accountTypeLabel.text = account.type
        balanceLabel.text = String(account.balance)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AccountViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
