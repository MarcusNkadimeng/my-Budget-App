//
//  CategoryTableViewCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/16.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var categoryBalanceLabel: UILabel!
    
    // MARK: - Functions
    func populateWith(category: Category, balance: Int) {
        categoryNameLabel.text = category.name
        categoryBalanceLabel.text = "R" + "\(String(format: "%.2f", Double(balance) / 1000.00))"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        UINib(nibName: NibIdentifiers.categoryViewCellIdentifier, bundle: nil)
    }
}
