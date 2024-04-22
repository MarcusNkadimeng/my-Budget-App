//
//  SignUpViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Text fields
    @IBOutlet private weak var fullnameField: UITextField!
    @IBOutlet private weak var emailAddressField: UITextField!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    // MARK: - signUp token
    private var signedUp = false
    
    @IBAction func signedUpClicked(_ sender: Any) { 
        signedUp = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Segue to validate credentials and log in
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpSegue" {
            guard let username = usernameField.text else { return }
            guard let password = passwordField.text else { return }
            guard let fullname = fullnameField.text else { return }
            guard let emailAddress = emailAddressField.text else { return }
            
            let primaryUser = User(username: username, password: password, fullname: fullname, emailAddress: emailAddress)
            
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.userTwo = primaryUser
            } else {
                let alertController = UIAlertController(
                                title: "Incomplete user details",
                                message: "Enter user information",
                                preferredStyle: .alert
                            )
                alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                present(alertController, animated: true, completion: nil)
            }
        }
    }

}
