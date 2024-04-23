import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    let userVM = UserViewModel.shared // Use shared instance
    private var loggedInUser: User?
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let username = usernameField.text,
              let password = passwordField.text else {
            return
        }
        
        if let user = userVM.login(username: username, password: password) {
            loggedInUser = user
            performSegue(withIdentifier: Segues.loginSegue, sender: self)
        } else {
            let alertController = UIAlertController(
                title: UIComponents.userAlertTitle,
                message: UIComponents.userAlertMessage,
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: UIComponents.uiAlertAction, style: .default))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
