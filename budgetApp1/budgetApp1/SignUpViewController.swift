import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var fullname: UITextField!
    @IBOutlet private weak var emailAddress: UITextField!
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    // MARK: - Variables
   
    private lazy var userViewModel = UserViewModel(authenticationRepository: AuthenticationRepository())
    
    // MARK: - IBActions
    @IBAction func signUpClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text,
              let fullname = fullname.text,
              let emailAddress = emailAddress.text else {
            return
        }
        userViewModel.createUser(username: username, password: password, fullname: fullname, emailAddress: emailAddress)
    }
}
