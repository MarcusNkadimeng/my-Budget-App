//
//  AccountTransactionsViewModelTests.swift
//  budgetApp1Tests
//
//  Created by Lehlohonolo Nkadimeng on 2024/06/28.
//

import XCTest
@testable import budgetApp1

class AccountTransactionsViewModelTests: XCTestCase {

    var viewModel: AccountTransactionsViewModel!
    var mockRepository: MockTransactionRepository!
    var mockDelegate: MockAccountsTransactionViewModelDelegate!
    
    override func setUpWithError() throws {
        super.setUp()
        mockRepository = MockTransactionRepository()
        mockDelegate = MockAccountsTransactionViewModelDelegate()
        viewModel = AccountTransactionsViewModel(repository: mockRepository, delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        mockRepository = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchTransactionsForAccountSuccess() {
        let accountID = "1"
        let transaction1 = Transaction(
            id: "1",
            date: "2024-06-27",
            amount: -1000,
            memo: "Expense",
            cleared: nil,
            approved: true,
            flagColor: nil,
            flagName: nil,
            accountID: "1",
            accountName: "Account 1",
            payeeID: "1",
            payeeName: "Payee 1",
            categoryID: "1",
            categoryName: "Category 1",
            transferAccountID: nil,
            transferTransactionID: nil,
            matchedTransactionID: nil,
            importID: nil,
            importPayeeName: nil,
            importPayeeNameOriginal: nil,
            debtTransactionType: nil,
            deleted: false,
            subtransactions: nil
        )
        
        let transaction2 = Transaction(
            id: "2",
            date: "2024-06-28",
            amount: 1500,
            memo: "Income",
            cleared: nil,
            approved: true,
            flagColor: nil,
            flagName: nil,
            accountID: "1",
            accountName: "Account 1",
            payeeID: "2",
            payeeName: "Payee 2",
            categoryID: "2",
            categoryName: "Category 2",
            transferAccountID: nil,
            transferTransactionID: nil,
            matchedTransactionID: nil,
            importID: nil,
            importPayeeName: nil,
            importPayeeNameOriginal: nil,
            debtTransactionType: nil,
            deleted: false,
            subtransactions: nil
        )
        mockRepository.transactions = [transaction1, transaction2]
        
        viewModel.fetchTransactionsForAccount(accountID: accountID)
        
        XCTAssertEqual(viewModel.transactionListCount, 2)
        XCTAssertEqual(viewModel.transaction(atIndex: 0)?.id, "1")
        XCTAssertEqual(viewModel.transaction(atIndex: 1)?.id, "2")
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertFalse(mockDelegate.showErrorCalled)
    }
    
    func testFetchTransactionsForAccountFailure() {
        let accountID = "1"
        mockRepository.shouldReturnError = true
        viewModel.fetchTransactionsForAccount(accountID: accountID)
        
        XCTAssertEqual(viewModel.transactionListCount, 0)
        XCTAssertNil(viewModel.transaction(atIndex: 0))
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertFalse(mockDelegate.reloadViewCalled)
    }
    
    func testFetchTransactionsSuccess() {
            let transaction = Transaction(
                id: "1",
                date: "2024-05-12",
                amount: 1000,
                memo: "Groceries",
                cleared: "cleared",
                approved: true,
                flagColor: nil,
                flagName: nil,
                accountID: "account1",
                accountName: "Checking",
                payeeID: "payee1",
                payeeName: "Supermarket",
                categoryID: "category1",
                categoryName: "Food",
                transferAccountID: nil,
                transferTransactionID: nil,
                matchedTransactionID: nil,
                importID: nil,
                importPayeeName: nil,
                importPayeeNameOriginal: nil,
                debtTransactionType: nil,
                deleted: false,
                subtransactions: nil
            )
            mockRepository.transactions = [transaction]
            viewModel.fetchTransactions()

            XCTAssertTrue(mockDelegate.reloadViewCalled)
            XCTAssertEqual(viewModel.transactionListCount, 1)
            XCTAssertEqual(viewModel.transaction(atIndex: 0)?.id, "1")
        }
    
    func testFetchTransactionsFailure() {
        mockRepository.shouldReturnError = true
        
        viewModel.fetchTransactions()
        
        XCTAssertEqual(viewModel.transactionListCount, 0)
        XCTAssertNil(viewModel.transaction(atIndex: 0))
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertFalse(mockDelegate.reloadViewCalled)
    }
    
    func testFilterTransactions() {
        let expenseTransaction = Transaction(
            id: "1",
            date: "2024-05-12",
            amount: -500,
            memo: "Groceries",
            cleared: "cleared",
            approved: true,
            flagColor: nil,
            flagName: nil,
            accountID: "account1",
            accountName: "Checking",
            payeeID: "payee1",
            payeeName: "Supermarket",
            categoryID: "category1",
            categoryName: "Food",
            transferAccountID: nil,
            transferTransactionID: nil,
            matchedTransactionID: nil,
            importID: nil,
            importPayeeName: nil,
            importPayeeNameOriginal: nil,
            debtTransactionType: nil,
            deleted: false,
            subtransactions: nil
        )
        
        let incomeTransaction = Transaction(
            id: "2",
            date: "2024-05-12",
            amount: 1000,
            memo: "Salary",
            cleared: "cleared",
            approved: true,
            flagColor: nil,
            flagName: nil,
            accountID: "account1",
            accountName: "Checking",
            payeeID: "payee2",
            payeeName: "Employer",
            categoryID: "category2",
            categoryName: "Income",
            transferAccountID: nil,
            transferTransactionID: nil,
            matchedTransactionID: nil,
            importID: nil,
            importPayeeName: nil,
            importPayeeNameOriginal: nil,
            debtTransactionType: nil,
            deleted: false,
            subtransactions: nil
        )
        
        mockRepository.transactions = [expenseTransaction, incomeTransaction]
        viewModel.fetchTransactions()
        
        viewModel.filterTransactions(segmentIndex: 0)
        
        XCTAssertEqual(viewModel.expenses?.count, 1)
        XCTAssertEqual(viewModel.income?.count, 1)
        XCTAssertEqual(viewModel.expenses?.first?.id, "1")
        XCTAssertEqual(viewModel.income?.first?.id, "2")
    }
}

class MockAccountsTransactionViewModelDelegate: AccountsTransactionViewModelDelegate {
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
