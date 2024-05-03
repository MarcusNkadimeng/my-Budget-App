import Foundation

class UserViewModel {
    
    let authenticationRepository: AuthenticationRepositoryType
    
    private var userData = [UserEntity]()
    let coreDataHandler = CoreDataHandler()
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    func fetchAllUsers() {
        do {
            try userData = coreDataHandler.context.fetch(UserEntity.fetchRequest())
        } catch {
            print("Error fetching users: \(AuthError.failedTofetchUsers)")
        }
    }
    
    func createUser(username: String, password: String, fullname: String, emailAddress: String) {
        authenticationRepository.createUser(fullName: fullname, password: password, emailAddress: emailAddress, username: username)
    }
    
    func login(username: String, password: String) -> Bool {
        authenticationRepository.loginUser(username: username, password: password)
    }
}
