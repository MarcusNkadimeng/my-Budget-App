import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    let userViewModel = UserViewModel.shared // Use shared instance
    private var loggedInUser: User?
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text else {
            return
        }
        
        if let user = userViewModel.login(username: username, password: password) {
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
}
