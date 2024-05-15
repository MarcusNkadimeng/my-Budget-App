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
    @IBAction private func signUpClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text,
              let fullname = fullname.text,
              let emailAddress = emailAddress.text else {
            return
        }
        let isUserSignedUp = userViewModel.createUser(username: username, password: password, fullname: fullname, emailAddress: emailAddress)
        
        if isUserSignedUp {
            performSegue(withIdentifier: Segues.signUpSegue, sender: self)
        } else {
            let alertController = UIAlertController(
                title: UIComponents.userAlertTitleThree,
                message: UIComponents.userAlertMessageThree,
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: UIComponents.uiAlertAction, style: .default))
            present(alertController, animated: true, completion: nil)
        }

    }
}
