//
//  LoginViewController.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/17.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var user2 = User(username: "", password: "", fullname: "", emailAddress: "")
    var user1 = User.init(username: "", password: "", fullname: "", emailAddress: "")
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        
        if (username == user1.username && password == user1.password) {
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
