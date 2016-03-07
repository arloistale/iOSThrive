//
//  ThriveTests.swift
//  ThriveTests
//
//  Created by Jonathan Lu on 1/24/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import XCTest
@testable import Thrive

class ThriveTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: JournalEntry Tests
    func testJournalEntryInitialization() {
        // expected success
        let optNil = JournalEntry(date: NSDate(), moodIndex: 0, message: nil, photo: nil)
        
        // expected failure
        let moodLow = JournalEntry(date: NSDate(), moodIndex: -1, message: "LOw", photo: nil)
        let moodHigh = JournalEntry(date: NSDate(), moodIndex: 10000, message: "High", photo: nil)
        
        XCTAssertNotNil(optNil, "Opt nil entry must be valid")
        XCTAssertEqual(NSDate(), optNil?.date)
        
        XCTAssertNil(moodLow, "Mood low entry must be invalid")
        XCTAssertNil(moodHigh, "Mood high entry must be invalid")
    }
    
    func testCardInitialization() {
        // success
        let optNil = Card(date: NSDate(), moodIndex: 0, message: nil, photo: nil)
        
        // failure
        let moodLow = Card(date: NSDate(), moodIndex: -1, message: "LOw", photo: nil)
        let moodHigh = Card(date: NSDate(), moodIndex: 10000, message: "High", photo: nil)
        
        XCTAssertNotNil(optNil, "Opt nil card must be valid")
        XCTAssertEqual(NSDate(), optNil?.date)
        
        XCTAssertNil(moodLow, "Mood low card must be invalid")
        XCTAssertNil(moodHigh, "Mood high card must be invalid")
    }
}
