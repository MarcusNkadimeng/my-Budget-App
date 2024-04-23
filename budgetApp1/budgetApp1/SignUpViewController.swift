import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var fullnameField: UITextField!
    @IBOutlet private weak var emailAddressField: UITextField!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    // MARK: - Variables
    let userVM = UserViewModel.shared // Use shared instance
    
    @IBAction func signUpClicked(_ sender: Any) {
        guard let username = usernameField.text,
              let password = passwordField.text,
              let fullname = fullnameField.text,
              let emailAddress = emailAddressField.text else {
            return
        }
        let newUser = userVM.createUser(username: username, password: password, fullname: fullname, emailAddress: emailAddress)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
