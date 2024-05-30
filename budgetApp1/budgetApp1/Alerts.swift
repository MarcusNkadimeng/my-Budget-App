//
//  ProceedAlert.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import UIKit

struct Alert {
    
    // MARK: - Alerts
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

    // MARK: - Loading Indicator
    private static var progressView: UIActivityIndicatorView?
    
    static func showProgressView(on view: UIView) {
        if progressView == nil {
            let progressView = UIActivityIndicatorView(style: .large)
            progressView.center = view.center
            progressView.color = .gray
            progressView.hidesWhenStopped = true
            self.progressView = progressView
            view.addSubview(progressView)
        }
        
        progressView?.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    static func hideProgressView(from view: UIView) {
        progressView?.stopAnimating()
        progressView?.removeFromSuperview()
        progressView = nil
        view.isUserInteractionEnabled = true
    }
}
