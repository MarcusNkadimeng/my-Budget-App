//
//  ProfileViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/29.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var comingSoonLabel: UILabel!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        comingSoonLabel.text = UIComponents.comingsoonLabel
    }
    
    @IBAction private func logoutClicked(_ sender: Any) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate,
              let window = delegate.window else {
            return
        }
        
        let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        window.rootViewController = loginViewController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
