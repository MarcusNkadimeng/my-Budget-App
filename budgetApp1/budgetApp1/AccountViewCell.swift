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
    @IBOutlet private weak var accountClearedLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var accountType: UILabel!
    @IBOutlet private weak var accountTypeLabel: UILabel!
    
    private let uiSpecs = UISpecs()
    
    // MARK: - functions
    func populateWith(account: Account) {
        accountNameLabel.text = account.name
        accountClearedLabel.text = UIComponents.accountClearedBalance
        balanceLabel.text = String(format: "%.2f", Double(account.balance) / 1000.00)
        accountType.text = UIComponents.accountTypeLabel
        accountTypeLabel.text = account.type
        accountNameLabel.textColor = uiSpecs.primaryColourOne
        backgroundColor = UIColor.clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
//        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    private func setupUI() {
        containerView.layer.cornerRadius = 10.0
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = uiSpecs.tetiaryColour.cgColor
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 5
        containerView.layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let separatorHeight: CGFloat = 3.0
//        for subview in self.subviews {
//            if subview != contentView && subview.frame.height < 2 {
//                subview.removeFromSuperview()
//            }
//        }
//        let separatorView = UIView(frame: CGRect(x: 16, y: self.bounds.height - separatorHeight, width: self.bounds.width - 32, height: separatorHeight))
//        separatorView.backgroundColor = uiSpecs.tetiaryColour
//        self.addSubview(separatorView)
//        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//    }
    
    
    static func nib() -> UINib {
        UINib(nibName: NibIdentifiers.accountViewCellIdentifier, bundle: nil)
    }
}
