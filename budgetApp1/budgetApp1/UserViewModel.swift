import Foundation

class UserViewModel {
    
    let authenticationRepository: AuthenticationRepositoryType
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    func createUser(username: String, password: String) -> Bool {
        authenticationRepository.createUser(password: password, username: username)
    }
    
    func login(username: String, password: String) -> Bool {
        authenticationRepository.loginUser(username: username, password: password)
    }
}
