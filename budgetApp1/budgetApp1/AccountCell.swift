//
//  AccountCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/04.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var AccountNameLabel: UILabel!
    @IBOutlet weak var AccountTypeLAbel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    func populateWith(account: Account){
        AccountNameLabel.text = account.name
        AccountTypeLAbel.text = account.type
        balanceLabel.text = String(account.balance)
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
