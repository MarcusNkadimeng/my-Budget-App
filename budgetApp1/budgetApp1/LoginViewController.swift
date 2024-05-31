import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    // MARK: - Variables
    private lazy var userViewModel = UserViewModel(authenticationRepository: AuthenticationRepository())
    private var loggedInStatus = false
    
    // MARK: - IBActions
    @IBAction private func loginClicked(_ sender: Any) {
        guard let username = username.text,
              let password = password.text else { return }
        
        loggedInStatus = userViewModel.login(username: username, password: password)
        
        if loggedInStatus {
            CoreDataHandler().saveLoggedInUser(username: username)
            performSegue(withIdentifier: Segues.loginSegue, sender: self)
        } else {
            showBasicAlert(title: UIComponents.userAlertTitle, message: UIComponents.userAlertMessage)
        }
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loggedInStatus = false
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
}
