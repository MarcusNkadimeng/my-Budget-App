//
//  LoginViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    var userTwo = User(username: "", password: "", fullname: "", emailAddress: "")
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        
        if (username == userTwo.username && password == userTwo.password) {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
        else {
            let alertController = UIAlertController(
                            title: "Invalid credentials",
                            message: "Enter valid username and password",
                            preferredStyle: .alert
                        )
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            present(alertController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
