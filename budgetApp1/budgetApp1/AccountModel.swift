//
//  AccountModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

// MARK: - Account
struct AccountData: Codable {
    let data: AccountDataClass
}

// MARK: - AccountDataClass
struct AccountDataClass: Codable {
    let accounts: [Account]
    let serverKnowledge: Int

    enum CodingKeys: String, CodingKey {
        case accounts
        case serverKnowledge = "server_knowledge"
    }
}

// MARK: - Account
struct Account: Codable {
    let id, name, type: String
    let onBudget, closed: Bool
    let note: String?
    let balance, clearedBalance, unclearedBalance: Int
    let transferPayeeID: String
    let directImportLinked, directImportInError: Bool
    let lastReconciledAt: String?
    let debtOriginalBalance: Int?
    let debtInterestRates, debtMinimumPayments, debtEscrowAmounts: Debt
    let deleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, type
        case onBudget = "on_budget"
        case closed, note, balance
        case clearedBalance = "cleared_balance"
        case unclearedBalance = "uncleared_balance"
        case transferPayeeID = "transfer_payee_id"
        case directImportLinked = "direct_import_linked"
        case directImportInError = "direct_import_in_error"
        case lastReconciledAt = "last_reconciled_at"
        case debtOriginalBalance = "debt_original_balance"
        case debtInterestRates = "debt_interest_rates"
        case debtMinimumPayments = "debt_minimum_payments"
        case debtEscrowAmounts = "debt_escrow_amounts"
        case deleted
    }
}

// MARK: - Debt
struct Debt: Codable {
}
