import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    // MARK: - Variables
    private lazy var userViewModel = UserViewModel(authenticationRepository: AuthenticationRepository())
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        username.layer.borderWidth = 3.0
        password.layer.borderWidth = 3.0
        password.layer.cornerRadius = 15.0
        username.layer.cornerRadius = 15.0
        password.layer.borderColor = UIColor.accent.cgColor
        username.layer.borderColor = UIColor.accent.cgColor
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 150
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - IBActions
    @IBAction private func signUpClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text else {
            return
        }
        let isUserSignedUp = userViewModel.createUser(username: username, password: password)
        
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
