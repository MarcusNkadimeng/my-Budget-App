//
//  BudgetOverviewTableViewCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/24.
//

import UIKit

class BudgetOverviewTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var currentBalance: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var lastModified: UILabel!
    @IBOutlet private weak var lastModifiedLabel: UILabel!
    
    // MARK: - Functions
    func populateWith(budget: Budget, budgetTotal: Double) {
        lastModifiedLabel.text = budget.lastModifiedOn
        balanceLabel.text = String(budgetTotal)
        lastModified.text = UIComponents.lastModifiedLabel
        currentBalance.text = UIComponents.currentBalanceLabel
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib() -> UINib {
        UINib(nibName: NibIdentifiers.budgetOverViewCellIdentifier, bundle: nil)
    }
}
