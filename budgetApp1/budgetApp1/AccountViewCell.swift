//
//  AccountCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/04.
//

import UIKit

class AccountViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var accountNameLabel: UILabel!
    @IBOutlet private weak var accountTypeLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    
    private let uiSpecs = UISpecs()
    
    // MARK: - functions
    func populateWith(account: Account) {
        accountNameLabel.text = account.name
        accountTypeLabel.text = UIComponents.accountClearedBalance
        balanceLabel.text = String(Double(account.balance) / 1000.00)
        accountNameLabel.textColor = uiSpecs.primaryColourTwo
        backgroundColor = UIColor.clear
    }
    
    static func nib() -> UINib {
        UINib(nibName: NibIdentifiers.AccountViewCellIdentifier, bundle: nil)
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
