import Foundation

class UserViewModel {
    
    let authenticationRepository: AuthenticationRepositoryType
    
    private var userData = [UserEntity]()
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    func fetchAllUsers() {
        switch authenticationRepository.fetchAllUsers() {
        case .success(let users):
            userData = users
        case .failure(let error):
            print("Error fetching users: \(error)")
        }
    }
    
    func createUser(username: String, password: String, fullname: String, emailAddress: String) {
        authenticationRepository.createUser(fullName: fullname, password: password, emailAddress: emailAddress, username: username)
    }
    
    func login(username: String, password: String) -> Bool {
        authenticationRepository.loginUser(username: username, password: password)
    }
}
