import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    // MARK: - Variables
    private lazy var userViewModel = UserViewModel(authenticationRepository: AuthenticationRepository())
    private var loggedInStatus = false
    
    // MARK: - IBActions
    @IBAction func loginClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text else { return }
        
        loggedInStatus = userViewModel.login(username: username, password: password)
        
        if loggedInStatus {
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
