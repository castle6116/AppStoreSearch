//
//  SearchTableViewControllerTests.swift
//  SearchTableViewControllerTests
//
//  Created by 김진우 on 2023/03/21.
//

import XCTest
@testable import AppStoreSearch

final class SearchTableViewControllerTests: XCTestCase {
    
    func testSearchAPI() throws {
        let term = "카카오뱅크"
        let promise = expectation(description: "iTunes API CALL timeout")
        
        Network.default.AppstoreSearch("https://itunes.apple.com/search?term=\(term)&country=kr&entity=software&limit=10") { searchData, statusCode, error  in
            guard let statusCode = statusCode else { return XCTFail("Status code: nil") }
            if statusCode == 200 {
                promise.fulfill()
            } else if statusCode == 400 {
                XCTFail("Status code: \(statusCode)")
            }
        }
        
        wait(for: [promise], timeout: 3)
    }
    
}
