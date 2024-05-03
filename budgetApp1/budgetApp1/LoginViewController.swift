import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - variables
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    private lazy var userViewModel = UserViewModel(authenticationRepository: AuthenticationRepository())
    
    private var loggedInStatus = false
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text else { return }
        
        loggedInStatus = userViewModel.login(username: username, password: password)
        
        if loggedInStatus == true {
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
