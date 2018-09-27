//
//  MovieInfoUITests.swift
//  MovieInfoUITests
//
//  Created by Siva.T on 22/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import XCTest

class MovieInfoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCollectionViewScrollingAndTaped() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        
        let moviesListButton = app.navigationBars["MovieInfo.MovieDetailsView"].buttons["Movies List"]
        moviesListButton.tap()
        
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 10).children(matching: .other).element
        element.swipeUp()
        element.swipeUp()
        element.swipeUp()
        element.swipeUp()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 6).children(matching: .other).element.tap()
        moviesListButton.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testMovieDetailPageDiscription(){

        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Show Full..."]/*[[".cells.buttons[\"Show Full...\"]",".buttons[\"Show Full...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tagline"].press(forDuration: 2.9);/*[[".cells.staticTexts[\"Tagline\"]",".tap()",".press(forDuration: 2.9);",".staticTexts[\"Tagline\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Show Less..."]/*[[".cells.buttons[\"Show Less...\"]",".buttons[\"Show Less...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["MovieInfo.MovieDetailsView"].buttons["Movies List"].tap()
    
    }
    
    func testMovieDetailPageScrollAndExpand(){
        
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 9).children(matching: .other).element.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Show Full..."]/*[[".cells.buttons[\"Show Full...\"]",".buttons[\"Show Full...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tagline"]/*[[".cells.staticTexts[\"Tagline\"]",".staticTexts[\"Tagline\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tagline"].press(forDuration: 2.9);/*[[".cells.staticTexts[\"Tagline\"]",".tap()",".press(forDuration: 2.9);",".staticTexts[\"Tagline\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/

        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tagline"]/*[[".cells.staticTexts[\"Tagline\"]",".staticTexts[\"Tagline\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Show Less..."]/*[[".cells.buttons[\"Show Less...\"]",".buttons[\"Show Less...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let moviesListButton = app.navigationBars["MovieInfo.MovieDetailsView"].buttons["Movies List"]
        moviesListButton.tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 5).children(matching: .other).element.tap()
        moviesListButton.tap()
        
        
    }


    
}
