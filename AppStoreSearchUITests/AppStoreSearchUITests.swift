//
//  AppStoreSearchUITests.swift
//  AppStoreSearchUITests
//
//  Created by 김진우 on 2023/03/21.
//

import XCTest

final class AppStoreSearchUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApp() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["검색"].tap()
        
        let searchField = app.navigationBars["검색"].searchFields["게임, 앱, 스토리 등"]
        searchField.tap()
        searchField.typeText("카")
        searchField.typeText("카")
        searchField.typeText("오")
        searchField.typeText("뱅")
        searchField.typeText("크")
        app.buttons["Search"].tap()
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: 2)
        searchField.tap()
        searchField.typeText(deleteString)
        app.buttons["Search"].tap()
        app.navigationBars["검색"].buttons["Cancel"].tap()
        
        
        
        searchField.tap()
        searchField.typeText("카")
        searchField.typeText("카")
        searchField.typeText("오")
        app.windows.staticTexts["카카오"].tap()
        app.navigationBars["검색"].buttons["Cancel"].tap()
        
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["카카오뱅크"]/*[[".cells.staticTexts[\"카카오뱅크\"]",".staticTexts[\"카카오뱅크\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchResultTableView = app.windows
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element
        searchResultTableView.tap()
        
        let backButton = app.navigationBars["AppStoreSearch.SearchDetailCollectionView"].buttons["검색"]
        backButton.tap()
        searchResultTableView.tap()
        
        let searchDetailCollectionView = searchResultTableView.children(matching: .collectionView).element
        let evalutionCell = searchDetailCollectionView
            .children(matching: .cell).element(boundBy: 1)
            .collectionViews.children(matching: .cell).element(boundBy: 2)
            .children(matching: .other).element
            .children(matching: .other).element
        evalutionCell.swipeLeft()
        evalutionCell.swipeLeft()
        
        let imageCell = searchDetailCollectionView
            .children(matching: .cell).element(boundBy: 2)
            .children(matching: .other).element
            .collectionViews.children(matching: .cell).element(boundBy: 1)
            .children(matching: .other).element
        
        for _ in 0...5 {
            imageCell.swipeLeft()
        }
        
        searchDetailCollectionView.swipeUp()
        
        let seeMoreButton = app.collectionViews
        seeMoreButton.staticTexts["더 보기"].tap()
        
        for _ in 0...7 {
            searchDetailCollectionView.swipeUp()
        }
        
        backButton.tap()
        
        app.navigationBars["검색"].buttons["Cancel"].tap()
    }
}
