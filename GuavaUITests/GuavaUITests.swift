//
//  GuavaUITests.swift
//  GuavaUITests
//
//  Created by Susim Samanta on 08/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import XCTest

class GuavaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.buttons["SIGNUP"].tap()
        snapshot("01SignupScreen")
        tablesQuery.buttons["LOGIN"].tap()
        snapshot("02LoginScreen")
        tablesQuery.buttons["LOGIN"].tap()
        snapshot("03MyCardScreen")
    }
    
}
