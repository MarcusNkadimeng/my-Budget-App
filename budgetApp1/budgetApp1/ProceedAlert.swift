//
//  ProceedAlert.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import UIKit

struct Alert {
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.present(alert, animated: true)
           
    }
    
    static func showProceedToBookingAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Proceed to booking", message: "Your trusted travel agents")
    }
    
    static func authenticationAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Invalid credentials", message: "Enter valid username and password")
    }

}
