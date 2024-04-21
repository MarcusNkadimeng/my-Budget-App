//
//  SignUpViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var signedUp = false
    
    @IBAction func signedUpClicked(_ sender: Any) { }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpSegue" {
            guard let username = usernameField.text else { return }
            guard let password = passwordField.text else { return }
            guard let fullname = fullnameField.text else { return }
            guard let emailAddress = emailAddressField.text else { return }
            
            let primaryUser = User(username: username, password: password, fullname: fullname, emailAddress: emailAddress)
            
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.user1 = primaryUser
                signedUp = true
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
