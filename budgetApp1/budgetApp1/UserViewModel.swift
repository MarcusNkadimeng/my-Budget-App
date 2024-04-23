import Foundation

class UserViewModel {
    
    // MARK: - Singleton instantiation of ViewModel
    static let shared = UserViewModel()
    
    private var users: [User] = []
    
    private init() {}
    
    func createUser(username: String, password: String, fullname: String, emailAddress: String) -> User {
        let user = User(username: username, password: password, fullname: fullname, emailAddress: emailAddress)
        users.append(user)
        return user
    }
    
    func login(username: String, password: String) -> User? {
        users.first { $0.username == username && $0.password == password }
    }
}
