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
    
    @IBAction func signedUpClicked(_ sender: Any) {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        
        if (username != "" && password != "") {
            signedUp = true
            print("user has signed up with ff credentials:", username, password)
        }
        else {
            signedUp = false
            print("Please sign up")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpSegue" {
            guard let username = usernameField.text else { return }
            guard let password = passwordField.text else { return }
            guard let fullname = fullnameField.text else { return }
            guard let emailAddress = emailAddressField.text else { return }
            
            let primaryUser = user(username: username, password: password, fullname: fullname, emailAddress: emailAddress)
            
            if let LoginViewController = segue.destination as? LoginViewController {
                LoginViewController.user1 = primaryUser
                print("new user:",primaryUser, "has been passed to login")
                
            }
        }
    }

}
