//
//  Alerts.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/30.
//

import UIKit

extension UIViewController {
    
    // MARK: - Alerts
    func showBasicAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: UIComponents.uiAlertAction, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
