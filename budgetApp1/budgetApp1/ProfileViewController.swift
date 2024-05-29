//
//  ProfileViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/29.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Variables
    var username: String?
    var loggedInStatus = true
    private lazy var viewModel = ProfileViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeImage()
        
        if let loggedInUser = viewModel.getLoggedInUser(), let username = loggedInUser.username {
            usernameLabel.text = username
        } else {
            usernameLabel.text = ""
        }
    }
    
    private func customizeImage() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.borderWidth = 2.0
        profileImage.layer.borderColor = UIColor.black.cgColor
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
