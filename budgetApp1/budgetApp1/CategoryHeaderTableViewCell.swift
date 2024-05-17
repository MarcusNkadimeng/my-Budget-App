//
//  CategoryHeaderTableViewCell.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/17.
//

import UIKit

class CategoryHeaderTableViewCell: UITableViewHeaderFooterView {

    // MARK: - UISpecs Dependency
    private let uiSpecs = UISpecs()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var categoryGroupLabel: UILabel!
    @IBOutlet private weak var categoryGroupTotal: UILabel!
    
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateWith(categoryGroup: CategoryGroup, totalBalance: Int) {
        categoryGroupLabel.text = categoryGroup.name
        categoryGroupTotal.text = "R" + "\(String(format: "%.2f", Double(totalBalance) / 1000.00))"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let separatorHeight: CGFloat = 3.0
        for subview in self.subviews {
            if subview != contentView && subview.frame.height < 2 {
                subview.removeFromSuperview()
            }
        }
        let separatorView = UIView(frame: CGRect(x: 16, y: self.bounds.height - separatorHeight, width: self.bounds.width - 32, height: separatorHeight))
        separatorView.backgroundColor = uiSpecs.tetiaryColour
        self.addSubview(separatorView)
    }
    
    static func nib() -> UINib {
        UINib(nibName: NibIdentifiers.categoryGroupHeaderCellIdentifier, bundle: nil)
    }
}
