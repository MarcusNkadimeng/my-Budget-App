//
//  CategoryModel.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/16.
//

import Foundation

// MARK: - Category data
struct CategoryData: Codable {
    let data: CategoryDataClass
}

// MARK: - CategoryDataClass
struct CategoryDataClass: Codable {
    let categoryGroups: [CategoryGroup]
    let serverKnowledge: Int

    enum CodingKeys: String, CodingKey {
        case categoryGroups = "category_groups"
        case serverKnowledge = "server_knowledge"
    }
}

// MARK: - CategoryGroup
struct CategoryGroup: Codable {
    let id, name: String
    let hidden, deleted: Bool
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id, categoryGroupID, categoryGroupName, name: String
    let hidden: Bool
    let originalCategoryGroupID, note: String?
    let budgeted, activity, balance: Int
    let goalType: GoalType?
    let goalDay, goalCadence, goalCadenceFrequency: Int?
    let goalCreationMonth: String?
    let goalTarget: Int
    let goalTargetMonth: String?
    let goalPercentageComplete, goalMonthsToBudget, goalUnderFunded, goalOverallFunded: Int?
    let goalOverallLeft: Int?
    let deleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case categoryGroupID = "category_group_id"
        case categoryGroupName = "category_group_name"
        case name, hidden
        case originalCategoryGroupID = "original_category_group_id"
        case note, budgeted, activity, balance
        case goalType = "goal_type"
        case goalDay = "goal_day"
        case goalCadence = "goal_cadence"
        case goalCadenceFrequency = "goal_cadence_frequency"
        case goalCreationMonth = "goal_creation_month"
        case goalTarget = "goal_target"
        case goalTargetMonth = "goal_target_month"
        case goalPercentageComplete = "goal_percentage_complete"
        case goalMonthsToBudget = "goal_months_to_budget"
        case goalUnderFunded = "goal_under_funded"
        case goalOverallFunded = "goal_overall_funded"
        case goalOverallLeft = "goal_overall_left"
        case deleted
    }
}

enum GoalType: String, Codable {
    case need = "NEED"
    case tBe = "TB"
}
