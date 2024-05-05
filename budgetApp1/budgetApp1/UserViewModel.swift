import Foundation

class UserViewModel {
    
    let authenticationRepository: AuthenticationRepositoryType
    
    private var userData = [UserEntity]()
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    func fetchAllUsers() -> Result<[UserEntity], Error> {
        authenticationRepository.fetchAllUsers()
    }
    
    func createUser(username: String, password: String, fullname: String, emailAddress: String) {
        authenticationRepository.createUser(fullName: fullname, password: password, emailAddress: emailAddress, username: username)
    }
    
    func login(username: String, password: String) -> Bool {
        authenticationRepository.loginUser(username: username, password: password)
    }
}
