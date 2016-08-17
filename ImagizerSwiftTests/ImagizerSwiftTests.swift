//
//  ImagizerSwiftTests.swift
//  ImagizerSwiftTests
//
//  Created by Nicholas Pettas on 8/16/16.
//  Copyright © 2016 Nicholas Pettas. All rights reserved.
//

import XCTest
import ImagizerSwift

class ImagizerSwiftTests: XCTestCase {
    private var dpr:Int = 0
    
    override func setUp() {
        super.setUp()
        self.dpr = Int(UIScreen.mainScreen().scale)

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildUrl() {
        let client = ImagizerClient(host: "example.com")
        let url = client.makeUrl("/image.jpg", params: ["width": "100"])
        let expected = "http://example.com/image.jpg?dpr=\(self.dpr)&width=100"
        XCTAssert(url.absoluteString == expected)
    }
}
