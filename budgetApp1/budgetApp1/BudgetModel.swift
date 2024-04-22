//
//  BudgetModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/03/26.
//

import Foundation

// MARK: - BudgetData
struct BudgetData: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let budgets: [Budget]
    let defaultBudget: Budget?
    
    enum CodingKeys: String, CodingKey {
        case budgets
        case defaultBudget = "default_budget"
    }
}

// MARK: - Budget
struct Budget: Codable {
    let id, name: String
    let lastModifiedOn, firstMonth: String
    let lastMonth: String
    let dateFormat: DateFormat
    let currencyFormat: CurrencyFormat
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case lastModifiedOn = "last_modified_on"
        case firstMonth = "first_month"
        case lastMonth = "last_month"
        case dateFormat = "date_format"
        case currencyFormat = "currency_format"
    }
}

// MARK: - CurrencyFormat
struct CurrencyFormat: Codable {
    let isoCode, exampleFormat: String
    let decimalDigits: Int
    let decimalSeparator: String
    let symbolFirst: Bool
    let groupSeparator, currencySymbol: String
    let displaySymbol: Bool
    
    enum CodingKeys: String, CodingKey {
        case isoCode = "iso_code"
        case exampleFormat = "example_format"
        case decimalDigits = "decimal_digits"
        case decimalSeparator = "decimal_separator"
        case symbolFirst = "symbol_first"
        case groupSeparator = "group_separator"
        case currencySymbol = "currency_symbol"
        case displaySymbol = "display_symbol"
    }
}

// MARK: - DateFormat
struct DateFormat: Codable {
    let format: String
}
