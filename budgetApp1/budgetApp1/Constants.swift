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
}

// MARK: - nib identifiers
struct NibIdentifiers {
    static let AccountViewCellIdentifier = "AccountViewCell"
    static let TransactionViewCellIdentifier = "TransactionTableViewCell"
}

// MARK: - UI Stuff
struct UIComponents {
    static let accountTypeLabel = "Cleared Balance (R)"
    static let userAlertTitle = "Login Failed!"
    static let userAlertMessage = "Enter valid username and password"
    static let userAlertTitleTwo = "Incomplete user details"
    static let userAlertMessageTwo = "Enter user information"
    static let uiAlertAction = "OK"
    static let uiALertComment = "Default action"
}

// MARK: - Segues
struct Segues {
    static let signUpSegue = "signUpSegue"
    static let loginSegue = "loginSegue"
}
