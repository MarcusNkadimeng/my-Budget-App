//
//  CategoryFooterTableViewCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/22.
//

import UIKit

class CategoryFooterTableViewCell: UITableViewHeaderFooterView {

    // MARK: - IBOutlets
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var categoryGroupTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func populateWith(totalBalance: Int) {
        totalLabel.text = UIComponents.categoryGroupTotalLabel
        categoryGroupTotalLabel.text = "R" + "\(String(format: "%.2f", Double(totalBalance) / 1000.00))"
    }
    
    static func nib() -> UINib {
        UINib(nibName: NibIdentifiers.categoryGroupFootCellIdentifier, bundle: nil)
    }
}
