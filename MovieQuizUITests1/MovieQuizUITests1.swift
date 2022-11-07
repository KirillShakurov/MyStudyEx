//
//  MovieQuizUITests1.swift
//  MovieQuizUITests1
//
//  Created by Kirill on 04.11.2022.
//

import XCTest

class MovieQuizUITests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        // это специальная настройка для тестов: если один тест не прошёл,
        // то следующие тесты запускаться не будут; и правда, зачем ждать?
        continueAfterFailure = false
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }

    func testYesButton() throws {
        let firstPoster = app.images["Poster"]
        app.buttons["Yes"].tap()
        let secondPoster = app.images["Poster"]
        let indexLabel = app.staticTexts["Index"]
        
        sleep(3)
        
        XCTAssertTrue(indexLabel.label == "2/10" )
        XCTAssertFalse(firstPoster == secondPoster)
    }
    
    func testNoButton() throws {
        let firstPoster = app.images["Poster"]
        app.buttons["No"].tap()
        let secondPoster = app.images["Poster"]
        let indexLabel = app.staticTexts["Index"]
        
        sleep(10)
        
        XCTAssertTrue(indexLabel.label == "2/10" )
        XCTAssertFalse(firstPoster == secondPoster)
    }
    
    func testAlertFinish() throws {
        for _ in 1...10{
            sleep(2)
            app.buttons["No"].tap()
            sleep(2)
        }
        sleep(2)
        
        let alert = app.alerts["Game_results"]
        
        
        XCTAssertTrue(app.alerts["Game_results"].exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть еще раз")
        
    }
    
    func testAlertDismiss() throws{
        for _ in 1...10 {
            sleep(2)
            app.buttons["No"].tap()
            sleep(2)
        }
        sleep(2)
        
        let alert = app.alerts["Game_results"]
        alert.buttons.firstMatch.tap()
        
        sleep(2)
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(app.alerts["Game_results"].exists)
        XCTAssertTrue(indexLabel.label == "1/10")
        
    }
}
