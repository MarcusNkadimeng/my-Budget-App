//
//  ProceedAlert.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import UIKit

struct LoadingIndicator {
    
    // MARK: - Loading Indicator variable
    private static var progressView: UIActivityIndicatorView?

    // MARK: - Loading Indicator functions
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
