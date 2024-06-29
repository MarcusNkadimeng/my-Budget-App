//
//  budgetApp1Tests.swift
//  budgetApp1Tests
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/06.
//

import XCTest
@testable import budgetApp1
import CoreData

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
    
    func testCreateUserSuccess() {
        mockRepository.shouldReturnError = false
        let userSignedUp = viewModel.createUser(username: "testUser", password: "testPassword")
        
        XCTAssertTrue(userSignedUp, "User creation should succeed")
        XCTAssertTrue(mockRepository.createUserCalled, "createUser should be called on the repository")
    }
    
    func testCreateUserFailure() {
        mockRepository.shouldReturnError = true
        let userSignedUp = viewModel.createUser(username: "testUser", password: "testPassword")
        
        XCTAssertFalse(userSignedUp, "User creation should fail")
    }
    
    func testLoginUserSuccess() {
        let username = "testUser"
        let password = "testPassword"
        mockRepository.loginResult = true
        let loginResult = viewModel.login(username: username, password: password)
        
        XCTAssertTrue(loginResult, "Login should succeed")
    }
    
    func testLoginUserFailure() {
        let username = "testUser"
        let password = "wrongPassword"
        mockRepository.loginResult = false
        let loginResult = viewModel.login(username: username, password: password)
        
        XCTAssertFalse(loginResult, "Login should fail")
    }
}

// MARK: - Mock Repository
class MockAuthenticationRepository: AuthenticationRepositoryType {
    
    let context: ManagedObjectContextProtocol
    
    init(context: ManagedObjectContextProtocol) {
        self.context = context
    }
    
    // MARK: - Variables
    var shouldReturnError = false
    var users: Result<[UserEntity], Error>?
    var createUserCalled = false
    var createdUsername: String?
    var createdPassword: String?
    var loginResult: Bool?
    
    // MARK: - Functions
    func createUser(password: String, username: String) -> Bool {
        createUserCalled = true
        if shouldReturnError {
            return false
        } else {
            createdUsername = username
            createdPassword = password
            return true
        }
    }
    
    func loginUser(username: String, password: String) -> Bool {
        if let loginResult = loginResult {
            return loginResult
        }
        let expectedUsername = "testUser"
        let expectedPassword = "testPassword"
        return username == expectedUsername && password == expectedPassword
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
