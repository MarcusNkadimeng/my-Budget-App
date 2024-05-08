//
//  budgetApp1Tests.swift
//  budgetApp1Tests
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/06.
//

import XCTest
@testable import budgetApp1
import CoreData

// MARK: - UserViewModel being tested
class UserViewModelTest: XCTestCase {
    
    // MARK: - Variables
    var viewModel: UserViewModel!
    var mockRepository: MockAuthenticationRepository!
     
    // MARK: - Functions
    override func setUpWithError() throws {
        super.setUp()
        let mockContext = MockContext()
        mockRepository = MockAuthenticationRepository(context: mockContext)
        viewModel = UserViewModel(authenticationRepository: mockRepository)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testCreateUser() {
        let mockContext = MockContext()
        let mockRepository = MockAuthenticationRepository(context: mockContext)
        let viewModel = UserViewModel(authenticationRepository: mockRepository)
        
        let userSignedUp = viewModel.createUser(username: "testUser", password: "testPassword", fullname: "Test User", emailAddress: "test@example.com")
        XCTAssertTrue(userSignedUp)
    }
    
    func testloginUser() {
        let username = "testUser"
        let password = "testPassword"
        mockRepository.loginResult = true
        let loginResult = viewModel.login(username: username, password: password)
        XCTAssertTrue(loginResult)
    }
}

// MARK: - Mock Repository
class MockAuthenticationRepository: AuthenticationRepositoryType {
    
    let context: ManagedObjectContextProtocol
    
    init(context: ManagedObjectContextProtocol) {
        self.context = context
    }
    
    // MARK: - Variables
    var users: Result<[UserEntity], Error>?
    var createUserCalled = false
    var createdUsername: String?
    var createdPassword: String?
    var createdFullName: String?
    var createdEmailAddress: String?
    var loginResult: Bool?
    
    // MARK: - Functions
    func createUser(fullName: String, password: String, emailAddress: String, username: String) -> Bool {
        createdUsername = username
        createdPassword = password
        createdFullName = fullName
        createdEmailAddress = emailAddress
        createUserCalled = true
        if createUserCalled {
            return createUserCalled
        } else {
            return false
        }
    }
    
    func loginUser(username: String, password: String) -> Bool {
        let expectedUsername = "testUser"
        let expectedPassword = "testPassword"
        if username == expectedUsername && password == expectedPassword {
            return true
        } else {
            return false
        }
    }
}

// MARK: - NSManagedObjectContext protocol & extension
protocol ManagedObjectContextProtocol {
    func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any]
    func save() throws
}

extension NSManagedObjectContext: ManagedObjectContextProtocol {}

// MARK: - MockContext
class MockContext: ManagedObjectContextProtocol {
    
    var fetchResult: Result<[NSManagedObject], Error> = .success([])
    
    func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        switch fetchResult {
        case .success(let objects):
            return objects
        case .failure(let error):
            throw error
        }
    }
    
    func save() throws {
    }
}

enum MockError: Error {
    case unknown
}
