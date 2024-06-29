//
//  OverviewViewModelTests.swift
//  budgetApp1Tests
//
//  Created by Lehlohonolo Nkadimeng on 2024/06/27.
//

import XCTest
@testable import budgetApp1

class OverviewViewModelTests: XCTestCase {

    // MARK: - Variables
    var viewModel: OverviewViewModel!
    var mockBudgetRepository: MockBudgetRepository!
    var mockAccountRepository: MockAccountRepository!
    var mockTransactionRepository: MockTransactionRepository!
    var mockDelegate: MockViewModelDelegate!
    
    override func setUpWithError() throws {
        super.setUp()
        mockBudgetRepository = MockBudgetRepository()
        mockAccountRepository = MockAccountRepository()
        mockTransactionRepository = MockTransactionRepository()
        mockDelegate = MockViewModelDelegate()
        
        viewModel = OverviewViewModel(repository: mockBudgetRepository,
                                      repositoryTwo: mockAccountRepository,
                                      repositoryThree: mockTransactionRepository,
                                      delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockBudgetRepository = nil
        mockAccountRepository = nil
        mockTransactionRepository = nil
        mockDelegate = nil
        super.tearDown()
    }

    // MARK: - Test functions
    func testFetchBudgetsSuccess() {
        let budget1 = Budget(
                id: "1",
                name: "Groceries",
                lastModifiedOn: "2023-12-01",
                firstMonth: "2024-01",
                lastMonth: "2024-12",
                dateFormat: DateFormat(format: "MM-dd-yyyy"),
                currencyFormat: CurrencyFormat(
                    isoCode: "USD",
                    exampleFormat: "$1,234.56",
                    decimalDigits: 2,
                    decimalSeparator: ".",
                    symbolFirst: true,
                    groupSeparator: ",",
                    currencySymbol: "$",
                    displaySymbol: true
                )
            )
            
            let budget2 = Budget(
                id: "2",
                name: "Entertainment",
                lastModifiedOn: "2023-12-05",
                firstMonth: "2024-01",
                lastMonth: "2024-12",
                dateFormat: DateFormat(format: "MM-dd-yyyy"),
                currencyFormat: CurrencyFormat(
                    isoCode: "USD",
                    exampleFormat: "$1,234.56",
                    decimalDigits: 2,
                    decimalSeparator: ".",
                    symbolFirst: true,
                    groupSeparator: ",",
                    currencySymbol: "$",
                    displaySymbol: true
                )
            )
        
        mockBudgetRepository.budgets = [budget1, budget2]
        viewModel.fetchBudgets()
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.budgetListCount, 2)
        XCTAssertEqual(viewModel.budget(atIndex: 0)?.id, "1")
        XCTAssertEqual(viewModel.budget(atIndex: 1)?.id, "2")
    }
    
    func testFetchBudgetsFailure() {
        mockBudgetRepository.shouldReturnError = true
        viewModel.fetchBudgets()
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "internalError")
    }
    
    func testBudgetAtIndex() {
        let budget1 = Budget(
            id: "1",
            name: "Groceries",
            lastModifiedOn: "2023-12-01",
            firstMonth: "2024-01",
            lastMonth: "2024-12",
            dateFormat: DateFormat(format: "MM-dd-yyyy"),
            currencyFormat: CurrencyFormat(
                isoCode: "USD",
                exampleFormat: "$1,234.56",
                decimalDigits: 2,
                decimalSeparator: ".",
                symbolFirst: true,
                groupSeparator: ",",
                currencySymbol: "$",
                displaySymbol: true
            )
        )
        
        let budget2 = Budget(
            id: "2",
            name: "Entertainment",
            lastModifiedOn: "2023-12-05",
            firstMonth: "2024-01",
            lastMonth: "2024-12",
            dateFormat: DateFormat(format: "MM-dd-yyyy"),
            currencyFormat: CurrencyFormat(
                isoCode: "USD",
                exampleFormat: "$1,234.56",
                decimalDigits: 2,
                decimalSeparator: ".",
                symbolFirst: true,
                groupSeparator: ",",
                currencySymbol: "$",
                displaySymbol: true
            )
        )
        
        mockBudgetRepository.budgets = [budget1, budget2]
        viewModel.fetchBudgets()
        
        XCTAssertTrue(mockDelegate.reloadViewCalled, "reloadView should be called on delegate")
        XCTAssertEqual(viewModel.budgetListCount, 2, "Expected 2 budgets after fetch")
        let fetchedBudget1 = viewModel.budget(atIndex: 0)
        let fetchedBudget2 = viewModel.budget(atIndex: 1)
        XCTAssertEqual(fetchedBudget1?.id, "1", "Expected budget id 1")
        XCTAssertEqual(fetchedBudget2?.id, "2", "Expected budget id 2")
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
        mockAccountRepository.accounts = [account]
        viewModel.fetchAccounts()
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.accountListCount, 1)
        XCTAssertEqual(viewModel.account(atIndex: 0)?.id, "1")
    }
    
    func testFetchAccountsFailure() {
        mockAccountRepository.shouldReturnError = true
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
        mockAccountRepository.accounts = [account1, account2]
        viewModel.fetchAccounts()
        let fetchedAccount1 = viewModel.account(atIndex: 0)
        let fetchedAccount2 = viewModel.account(atIndex: 1)
        XCTAssertEqual(fetchedAccount1?.id, "1")
        XCTAssertEqual(fetchedAccount2?.id, "2")
    }
    
    func testFetchTransactionsSuccess() {
        let transaction = Transaction(
            id: "1",
            date: "2024-06-27",
            amount: 100,
            memo: nil,
            cleared: nil,
            approved: true,
            flagColor: nil,
            flagName: nil,
            accountID: "1",
            accountName: "Checking",
            payeeID: "payee1",
            payeeName: "John Doe",
            categoryID: "cat1",
            categoryName: "General",
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
        mockTransactionRepository.transactions = [transaction]
        
        viewModel.fetchTransactions()
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertEqual(viewModel.transactionListCount, 1)
        XCTAssertEqual(viewModel.transaction(atIndex: 0)?.id, "1")
    }
    
    func testFetchTransactionsFailure() {
        mockTransactionRepository.shouldReturnError = true
        viewModel.fetchTransactions()
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "internalError")
    }
    
    func testTransactionAtIndex() {
        let transaction1 = Transaction(
            id: "1",
            date: "2024-06-27",
            amount: 1000,
            memo: "Transaction 1",
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
            memo: "Transaction 2",
            cleared: nil,
            approved: true,
            flagColor: nil,
            flagName: nil,
            accountID: "2",
            accountName: "Account 2",
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
        mockTransactionRepository.transactions = [transaction1, transaction2]
        
        viewModel.fetchTransactions()
        XCTAssertEqual(viewModel.transactionListCount, 2)
        XCTAssertEqual(viewModel.transaction(atIndex: 0)?.id, "1")
        XCTAssertEqual(viewModel.transaction(atIndex: 1)?.id, "2")
        XCTAssertEqual(viewModel.transaction(atIndex: 0)?.amount, 1000)
        XCTAssertEqual(viewModel.transaction(atIndex: 1)?.amount, 1500)
        XCTAssertEqual(viewModel.transaction(atIndex: 0)?.accountName, "Account 1")
        XCTAssertEqual(viewModel.transaction(atIndex: 1)?.accountName, "Account 2")
        XCTAssertEqual(viewModel.transaction(atIndex: 0)?.payeeName, "Payee 1")
        XCTAssertEqual(viewModel.transaction(atIndex: 1)?.payeeName, "Payee 2")
    }
}

// MARK: - Mock Repositories
class MockBudgetRepository: BudgetRepositoryType {
    
    var shouldReturnError = false
    var budgets: [Budget] = []
    
    func fetchBudgets(completion: @escaping BudgetsResult) {
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            let budgetData = BudgetData(data: DataClass(budgets: budgets, defaultBudget: nil))
            completion(.success(budgetData))
        }
    }
}

class MockTransactionRepository: TransactionRepositoryType {
    var shouldReturnError = false
    var transactions: [Transaction] = []
    var mockServerKnowledge = 0
    
    func fetchTransactions(completion: @escaping TransactionResult) {
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            let transactionDataClass = TransactionDataClass(transactions: transactions, serverKnowledge: mockServerKnowledge)
            let transactionData = TransactionData(data: transactionDataClass)
            completion(.success(transactionData))
        }
    }
    
    func fetchTransactionsForAccount(accountID: String, completion: @escaping TransactionResult) {
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            let transactionDataClass = TransactionDataClass(transactions: transactions, serverKnowledge: mockServerKnowledge)
            let transactionData = TransactionData(data: transactionDataClass)
            completion(.success(transactionData))
        }
    }
}

// MARK: - MockViewModelDelegate
class MockViewModelDelegate: ViewModelDelegate {
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
