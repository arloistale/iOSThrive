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
        let potentialEntry = JournalEntry(message: "Test Title", photo: nil)
        XCTAssertNotNil(potentialEntry)
        XCTAssertEqual(NSDate(), potentialEntry?.date)
        
        // expected failure
        let noTitle = JournalEntry(message: "", photo: nil)
        XCTAssertNil(noTitle, "Empty journal entry title must be invalid")
    }
}
