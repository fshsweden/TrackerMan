//
//  BrainTests.swift
//  FizzBuzz
//
//  Created by Peter Andersson on 14/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import XCTest
@testable import FizzBuzz

class BrainTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    func testIsDivisibleByThree() {
        let brain = Brain()
        let result = brain.isDivisibleBy(9, divisor: 3)
        XCTAssertEqual(result, true)
    }

    func testIsNotDivisibleByThree() {
        let brain = Brain()
        let result = brain.isDivisibleBy(10,divisor: 3)
        XCTAssertNotEqual(result, true)
    }
    
    func testIsDivisibleByFive() {
        let brain = Brain()
        let result = brain.isDivisibleBy(25,divisor: 5)
        XCTAssertEqual(result, true)
    }
    
    func testIsNotDivisibleByFive() {
        let brain = Brain()
        let result = brain.isDivisibleBy(26,divisor: 6)
        XCTAssertNotEqual(result, true)
    }
    
    func testSayFizz() {
        let brain = Brain()
        let result = brain.check(3)
        XCTAssertTrue(result == "Fizz")
    }
    
    func testSayBuzz() {
        let brain = Brain()
        let result = brain.check(5)
        XCTAssertEqual(result, "Buzz")
    }
    
    func testSayFizzBuzz() {
        let brain = Brain()
        let result = brain.check(15)
        XCTAssertEqual(result, "FizzBuzz")
    }
    
}
