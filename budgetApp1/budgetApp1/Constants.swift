//
//  Constants.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/22.
//

import Foundation

// MARK: - URL constants
struct URLConstants {
    static let accessToken = "?access_token=t_Ikm7Q2U94be-lmSn4blgh1sjIEf1dMF7Tv8jguvpU"
    static let baseURL = "https://api.ynab.com/v1/"
    static let budgetURL = baseURL + "budgets" + accessToken
    static let accountsURL = baseURL + "budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts" + accessToken
    static let transactionsURL = baseURL + "budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts/0515719a-f641-422b-8341-7073d5358dbe/transactions" + accessToken
    static let accountTransactionURL = baseURL + "budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/accounts/"
    static let categoryURL = baseURL + "budgets/2b0c25e3-0d5e-411d-a019-2522faa22c2b/categories" + accessToken
}

// MARK: - nib identifiers
struct NibIdentifiers {
    static let accountViewCellIdentifier = "AccountViewCell"
    static let TransactionViewCellIdentifier = "TransactionTableViewCell"
    static let categoryGroupHeaderCellIdentifier = "CategoryHeaderTableViewCell"
    static let categoryViewCellIdentifier = "CategoryTableViewCell"
    static let categoryGroupFootCellIdentifier = "CategoryFooterTableViewCell"
    static let budgetOverViewCellIdentifier = "BudgetOverviewTableViewCell"
}

// MARK: - UI Stuff
struct UIComponents {
    static let accountClearedBalance = "Cleared Balance (R)"
    static let userAlertTitle = "Login Failed"
    static let userAlertTitleThree = "User creation failed"
    static let userAlertMessage = "Enter valid username and password"
    static let userAlertMessageThree = "Try to create a user again"
    static let userAlertTitleTwo = "Incomplete user details"
    static let userAlertMessageTwo = "Enter user information"
    static let uiAlertAction = "OK"
    static let uiALertComment = "Default action"
    static let accountFatalError = "Selected account is nil"
    static let accountScreenHeader = "Accounts"
    static let recentTransactionLabel = "Most recent transactions"
    static let categoryScreenHeader = "Category Tracker"
    static let categoryGroupTotalLabel = "Total"
    static let currentBalanceLabel = "Current Balance (R)"
    static let lastModifiedLabel = "Last Modified"
}

// MARK: - Segues
struct Segues {
    static let signUpSegue = "signUpSegue"
    static let loginSegue = "loginSegue"
    static let accountTransactionsSegue = "ShowAccountTransactions"
}
