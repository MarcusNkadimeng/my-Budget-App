//
//  CategoryTrackerViewModelTests.swift
//  budgetApp1Tests
//
//  Created by Lehlohonolo Nkadimeng on 2024/06/27.
//

import XCTest
@testable import budgetApp1

class CategoryTrackerViewModelTests: XCTestCase {

    var viewModel: CategoryTrackerViewModel!
    var mockRepository: MockCategoryTrackerRepository!
    var mockDelegate: MockCategoryTrackerViewModelDelegate!
    
    override func setUpWithError() throws {
        super.setUp()
        mockRepository = MockCategoryTrackerRepository()
        mockDelegate = MockCategoryTrackerViewModelDelegate()
        viewModel = CategoryTrackerViewModel(repository: mockRepository, delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        mockRepository = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchCategoryGroupsSuccess() {
        let categoryGroup1 = CategoryGroup(id: "1", name: "Group 1", hidden: false, deleted: false, categories: [])
        let categoryGroup2 = CategoryGroup(id: "2", name: "Group 2", hidden: false, deleted: false, categories: [])
        let categoryData = CategoryData(data: CategoryDataClass(categoryGroups: [categoryGroup1, categoryGroup2], serverKnowledge: 1))
        mockRepository.categoryData = .success(categoryData)
        
        viewModel.fetchCategoryGroups()
        
        XCTAssertEqual(viewModel.categoryListCount, 2)
        XCTAssertNotNil(viewModel.categoryGroup(atIndex: 0))
        XCTAssertEqual(viewModel.categoryGroup(atIndex: 0)?.name, "Group 1")
        XCTAssertNotNil(viewModel.categoryGroup(atIndex: 1))
        XCTAssertEqual(viewModel.categoryGroup(atIndex: 1)?.name, "Group 2")
        XCTAssertTrue(mockDelegate.reloadViewCalled)
        XCTAssertFalse(mockDelegate.showErrorCalled)
    }
    
    func testFetchCategoryGroupsFailure() {
        mockRepository.categoryData = .failure(.parsingError)
        
        viewModel.fetchCategoryGroups()
        
        XCTAssertEqual(viewModel.categoryListCount, 0)
        XCTAssertNil(viewModel.categoryGroup(atIndex: 0))
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertFalse(mockDelegate.reloadViewCalled)
    }
    
    func testGroupCategories() {
        // Given
        let category1 = Category(
            id: "1",
            categoryGroupID: "1",
            categoryGroupName: "Group 1",
            name: "Category 1",
            hidden: false,
            originalCategoryGroupID: nil,
            note: nil,
            budgeted: 1000,
            activity: 500,
            balance: 500,
            goalType: nil,
            goalDay: nil,
            goalCadence: nil,
            goalCadenceFrequency: nil,
            goalCreationMonth: nil,
            goalTarget: 0,
            goalTargetMonth: nil,
            goalPercentageComplete: nil,
            goalMonthsToBudget: nil,
            goalUnderFunded: nil,
            goalOverallFunded: nil,
            goalOverallLeft: nil,
            deleted: false
        )
        
        let category2 = Category(
            id: "2",
            categoryGroupID: "1",
            categoryGroupName: "Group 1",
            name: "Category 2",
            hidden: false,
            originalCategoryGroupID: nil,
            note: nil,
            budgeted: 1500,
            activity: 600,
            balance: 900,
            goalType: nil,
            goalDay: nil,
            goalCadence: nil,
            goalCadenceFrequency: nil,
            goalCreationMonth: nil,
            goalTarget: 0,
            goalTargetMonth: nil,
            goalPercentageComplete: nil,
            goalMonthsToBudget: nil,
            goalUnderFunded: nil,
            goalOverallFunded: nil,
            goalOverallLeft: nil,
            deleted: false
        )
        
        viewModel.categoryGroupList = [
            CategoryGroup(id: "1", name: "Group 1", hidden: false, deleted: false, categories: [category1, category2])
        ]
        viewModel.groupCategories()
        
        XCTAssertEqual(viewModel.groupedCategories.count, 1)
        XCTAssertEqual(viewModel.categoryGroupBalances.count, 1)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let category = viewModel.category(atIndexPath: indexPath)
        XCTAssertNotNil(category)
        XCTAssertEqual(category?.id, "1")
        XCTAssertEqual(category?.name, "Category 1")
        XCTAssertEqual(category?.categoryGroupID, "1")
        XCTAssertEqual(category?.categoryGroupName, "Group 1")
        XCTAssertEqual(category?.balance, 500)
        
        let indexPath2 = IndexPath(row: 1, section: 0)
        let category2AtIndexPath2 = viewModel.category(atIndexPath: indexPath2)
        XCTAssertNotNil(category2AtIndexPath2)
        XCTAssertEqual(category2AtIndexPath2?.id, "2")
        XCTAssertEqual(category2AtIndexPath2?.name, "Category 2")
        XCTAssertEqual(category2AtIndexPath2?.categoryGroupID, "1")
        XCTAssertEqual(category2AtIndexPath2?.categoryGroupName, "Group 1")
        XCTAssertEqual(category2AtIndexPath2?.balance, 900)
    }
    
    func testCategoryGroupAtIndex() {
        let category1 = Category(
            id: "1",
            categoryGroupID: "1",
            categoryGroupName: "Group 1",
            name: "Category 1",
            hidden: false,
            originalCategoryGroupID: nil,
            note: nil,
            budgeted: 1000,
            activity: 500,
            balance: 500,
            goalType: nil,
            goalDay: nil,
            goalCadence: nil,
            goalCadenceFrequency: nil,
            goalCreationMonth: nil,
            goalTarget: 0,
            goalTargetMonth: nil,
            goalPercentageComplete: nil,
            goalMonthsToBudget: nil,
            goalUnderFunded: nil,
            goalOverallFunded: nil,
            goalOverallLeft: nil,
            deleted: false
        )
        
        let category2 = Category(
            id: "2",
            categoryGroupID: "1",
            categoryGroupName: "Group 1",
            name: "Category 2",
            hidden: false,
            originalCategoryGroupID: nil,
            note: nil,
            budgeted: 1500,
            activity: 600,
            balance: 900,
            goalType: nil,
            goalDay: nil,
            goalCadence: nil,
            goalCadenceFrequency: nil,
            goalCreationMonth: nil,
            goalTarget: 0,
            goalTargetMonth: nil,
            goalPercentageComplete: nil,
            goalMonthsToBudget: nil,
            goalUnderFunded: nil,
            goalOverallFunded: nil,
            goalOverallLeft: nil,
            deleted: false
        )
        
        viewModel.categoryGroupList = [CategoryGroup(id: "1", name: "Group 1", hidden: false, deleted: false, categories: [category1, category2])]
        let categoryGroup = viewModel.categoryGroup(atIndex: 0)
        
        XCTAssertNotNil(categoryGroup)
        XCTAssertEqual(categoryGroup?.id, "1")
        XCTAssertEqual(categoryGroup?.name, "Group 1")
        XCTAssertEqual(categoryGroup?.categories.count, 2)
    }
    
    func testCategoryAtIndexPath() {
        let category1 = Category(
            id: "1",
            categoryGroupID: "1",
            categoryGroupName: "Group 1",
            name: "Category 1",
            hidden: false,
            originalCategoryGroupID: nil,
            note: nil,
            budgeted: 1000,
            activity: 500,
            balance: 500,
            goalType: nil,
            goalDay: nil,
            goalCadence: nil,
            goalCadenceFrequency: nil,
            goalCreationMonth: nil,
            goalTarget: 0,
            goalTargetMonth: nil,
            goalPercentageComplete: nil,
            goalMonthsToBudget: nil,
            goalUnderFunded: nil,
            goalOverallFunded: nil,
            goalOverallLeft: nil,
            deleted: false
        )
        
        let category2 = Category(
            id: "2",
            categoryGroupID: "1",
            categoryGroupName: "Group 1",
            name: "Category 2",
            hidden: false,
            originalCategoryGroupID: nil,
            note: nil,
            budgeted: 1500,
            activity: 600,
            balance: 900,
            goalType: nil,
            goalDay: nil,
            goalCadence: nil,
            goalCadenceFrequency: nil,
            goalCreationMonth: nil,
            goalTarget: 0,
            goalTargetMonth: nil,
            goalPercentageComplete: nil,
            goalMonthsToBudget: nil,
            goalUnderFunded: nil,
            goalOverallFunded: nil,
            goalOverallLeft: nil,
            deleted: false
        )
        
        viewModel.categoryGroupList = [
            CategoryGroup(id: "1", name: "Group 1", hidden: false, deleted: false, categories: [category1, category2])
        ]
        viewModel.groupCategories()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let category = viewModel.category(atIndexPath: indexPath)
        XCTAssertNotNil(category)
        XCTAssertEqual(category?.id, "1")
        XCTAssertEqual(category?.name, "Category 1")
        XCTAssertEqual(category?.categoryGroupID, "1")
        XCTAssertEqual(category?.categoryGroupName, "Group 1")
        XCTAssertEqual(category?.balance, 500)
        
        let indexPath2 = IndexPath(row: 1, section: 0)
        let category2AtIndexPath2 = viewModel.category(atIndexPath: indexPath2)
        XCTAssertNotNil(category2AtIndexPath2)
        XCTAssertEqual(category2AtIndexPath2?.id, "2")
        XCTAssertEqual(category2AtIndexPath2?.name, "Category 2")
        XCTAssertEqual(category2AtIndexPath2?.categoryGroupID, "1")
        XCTAssertEqual(category2AtIndexPath2?.categoryGroupName, "Group 1")
        XCTAssertEqual(category2AtIndexPath2?.balance, 900)
    }
}

class MockCategoryTrackerRepository: CategoryTrackerRepositoryType {

    var categoryData: Result<CategoryData, APIError>?

    func fetchCategoryGroups(completion: @escaping CategoryResult) {
        if let categoryData = categoryData {
            completion(categoryData)
        }
    }
}

class MockCategoryTrackerViewModelDelegate: CategoryTrackerViewModelProtocol {

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
