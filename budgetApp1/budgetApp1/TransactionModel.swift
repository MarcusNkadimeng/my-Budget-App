//
//  TransactionModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/04/14.
//

import Foundation

// MARK: - TransactionData
struct TransactionData: Codable {
    let data: TransactionDataClass
}

// MARK: - TransactionDataClass
struct TransactionDataClass: Codable {
    let transactions: [Transaction]
    let serverKnowledge: Int

    enum CodingKeys: String, CodingKey {
        case transactions
        case serverKnowledge = "server_knowledge"
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let id, date: String
    let amount: Int
    let memo: String?
    let cleared: String?
    let approved: Bool
    let flagColor, flagName: String?
    let accountID: String
    let accountName: String;
    let payeeID, payeeName, categoryID, categoryName: String
    let transferAccountID, transferTransactionID, matchedTransactionID: String?
    let importID, importPayeeName: String?
    let importPayeeNameOriginal, debtTransactionType: String?
    let deleted: Bool
    let subtransactions: [Transaction]?

    enum CodingKeys: String, CodingKey {
        case id, date, amount, memo, cleared, approved
        case flagColor = "flag_color"
        case flagName = "flag_name"
        case accountID = "account_id"
        case accountName = "account_name"
        case payeeID = "payee_id"
        case payeeName = "payee_name"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case transferAccountID = "transfer_account_id"
        case transferTransactionID = "transfer_transaction_id"
        case matchedTransactionID = "matched_transaction_id"
        case importID = "import_id"
        case importPayeeName = "import_payee_name"
        case importPayeeNameOriginal = "import_payee_name_original"
        case debtTransactionType = "debt_transaction_type"
        case deleted, subtransactions
    }
}
