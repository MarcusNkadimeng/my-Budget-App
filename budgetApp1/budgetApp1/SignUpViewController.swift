import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var fullname: UITextField!
    @IBOutlet private weak var emailAddress: UITextField!
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    // MARK: - Variables
    let userViewModel = UserViewModel.shared // Use shared instance
    
    @IBAction func signUpClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text,
              let fullname = fullname.text,
              let emailAddress = emailAddress.text else {
            return
        }
        _ = userViewModel.createUser(username: username,
                                     password: password,
                                     fullname: fullname,
                                     emailAddress: emailAddress)
    }
}
