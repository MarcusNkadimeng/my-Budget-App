//
//  AccountViewModelTests.swift
//  budgetApp1Tests
//
//  Created by Lehlohonolo Nkadimeng on 2024/06/26.
//

import XCTest
@testable import budgetApp1

class AccountViewModelTests: XCTestCase {

    // MARK: - Variables
    var viewModel: AccountViewModel!
    var mockRepository: MockAccountRepository!
    var mockDelegate: MockAccountViewModelDelegate!
    
    override func setUpWithError() throws {
        super.setUp()
        mockRepository = MockAccountRepository()
        mockDelegate = MockAccountViewModelDelegate()
        viewModel = AccountViewModel(repository: mockRepository, delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchAccountsSuccess() {
        let account = Account(
            id: "1",
            name: "Checking",
            type: "bank",
            onBudget: true,
            closed: false,
            note: nil,
            balance: 1000,
            clearedBalance: 800,
            unclearedBalance: 200,
            transferPayeeID: "payee1",
            directImportLinked: false,
            directImportInError: false,
            lastReconciledAt: nil,
            debtOriginalBalance: nil,
            debtInterestRates: Debt(),
            debtMinimumPayments: Debt(),
            debtEscrowAmounts: Debt(),
            deleted: false
        )
        mockRepository.accounts = [account]
        viewModel.fetchAccounts()
        
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.accountListCount, 1)
        XCTAssertEqual(viewModel.account(atIndex: 0)?.id, "1")
    }
    
    func testFetchAccountsFailure() {
        mockRepository.shouldReturnError = true
        viewModel.fetchAccounts()
        
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "internalError")
    }
    
    func testAccountAtIndex() {
        let account1 = Account(
            id: "1",
            name: "Checking",
            type: "bank",
            onBudget: true,
            closed: false,
            note: nil,
            balance: 1000,
            clearedBalance: 800,
            unclearedBalance: 200,
            transferPayeeID: "payee1",
            directImportLinked: false,
            directImportInError: false,
            lastReconciledAt: nil,
            debtOriginalBalance: nil,
            debtInterestRates: Debt(),
            debtMinimumPayments: Debt(),
            debtEscrowAmounts: Debt(),
            deleted: false
        )
        
        let account2 = Account(
            id: "2",
            name: "Savings",
            type: "bank",
            onBudget: true,
            closed: false,
            note: nil,
            balance: 2000,
            clearedBalance: 1800,
            unclearedBalance: 200,
            transferPayeeID: "payee2",
            directImportLinked: false,
            directImportInError: false,
            lastReconciledAt: nil,
            debtOriginalBalance: nil,
            debtInterestRates: Debt(),
            debtMinimumPayments: Debt(),
            debtEscrowAmounts: Debt(),
            deleted: false
        )
        mockRepository.accounts = [account1, account2]
        viewModel.fetchAccounts()
        let fetchedAccount1 = viewModel.account(atIndex: 0)
        let fetchedAccount2 = viewModel.account(atIndex: 1)
        
        XCTAssertEqual(fetchedAccount1?.id, "1")
        XCTAssertEqual(fetchedAccount2?.id, "2")
    }
    
    func testAccountListCount() {
        let account = Account(
            id: "1",
            name: "Checking",
            type: "bank",
            onBudget: true,
            closed: false,
            note: nil,
            balance: 1000,
            clearedBalance: 800,
            unclearedBalance: 200,
            transferPayeeID: "payee1",
            directImportLinked: false,
            directImportInError: false,
            lastReconciledAt: nil,
            debtOriginalBalance: nil,
            debtInterestRates: Debt(),
            debtMinimumPayments: Debt(),
            debtEscrowAmounts: Debt(),
            deleted: false
        )
        mockRepository.accounts = [account]
        viewModel.fetchAccounts()
        
        XCTAssertEqual(viewModel.accountListCount, 1)
    }
    
    func testAccountListCountWhenEmpty() {
        mockRepository.accounts = []
        viewModel.fetchAccounts()
        
        XCTAssertEqual(viewModel.accountListCount, 0)
    }
}

// MARK: - Mock Repository
class MockAccountRepository: AccountRepositoryType {
    
    var shouldReturnError = false
    var accounts: [Account] = []
    var mockServerKnowledge = 0
    
    func fetchAccounts(completion: @escaping AccountResult) {
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            let accountDataClass = AccountDataClass(accounts: accounts, serverKnowledge: mockServerKnowledge)
            let accountData = AccountData(data: accountDataClass)
            completion(.success(accountData))
        }
    }
}

// MARK: - Mock Delegate
class MockAccountViewModelDelegate: AccountViewModelDelegate {
    var reloadViewCalled = false
    var showErrorCalled = false
    var errorMessage: String?
    
    func reloadView() {
        reloadViewCalled = true
    }
    
    func show(error: String) {
        showErrorCalled = true
        errorMessage = error
    }
}
