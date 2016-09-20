//
//  ImagizerSwiftTests.swift
//  ImagizerSwiftTests
//
//  Created by Nicholas Pettas on 8/16/16.
//

import XCTest
import ImagizerSwift

class ImagizerSwiftTests: XCTestCase {
    fileprivate var dpr:Double = 0
    
    override func setUp() {
        super.setUp()
        #if os(OSX)
            if let screen = NSScreen.main() {
                self.dpr = Double(screen.backingScaleFactor)
            }
        #else
            self.dpr = Double(UIScreen.main.scale)
        #endif
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBuildUrl() {
        let client = ImagizerClient(host: "example.com")
        let url = client.buildUrl("image.jpg", params: ["width": 100])
        print(url)
        let expected = "http://example.com/image.jpg?width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUrlWithSlash() {
        let client = ImagizerClient(host: "example.com")
        let url = client.buildUrl("/image.jpg", params: ["width": 100])
        print(url)
        let expected = "http://example.com/image.jpg?width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUrlHttps() {
        let client = ImagizerClient(host: "example.com", useHttps: true)
        let url = client.buildUrl("image.jpg", params: ["width": 100])
        print(url)
        let expected = "https://example.com/image.jpg?width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUlrWithHeight() {
        let client = ImagizerClient(host: "example.com")
        let url = client.buildUrl("image.jpg", params: ["width": 100, "height": 250])
        print(url)
        let expected = "http://example.com/image.jpg?height=250&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUlrWithHeightAndCropFit() {
        let client = ImagizerClient(host: "example.com")
        let url = client.buildUrl("image.jpg", params: ["width": 100, "height": 250, "crop": "fit"])
        print(url)
        let expected = "http://example.com/image.jpg?crop=fit&height=250&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUlrWithCustomCrop() {
        let client = ImagizerClient(host: "example.com")
        let url = client.buildUrl("image.jpg", params: ["crop": "100,100,100,50"])
        print(url)
        let expected = "http://example.com/image.jpg?crop=100,100,100,50"
        XCTAssert(url.absoluteString == expected)
    }

    func testBuildUrlWithAutoDpr() {
        let client = ImagizerClient(host: "example.com")
        client.autoDpr = true
        let url = client.buildUrl("image.jpg", params: ["width": 100])
        print(url)
        var expected = "http://example.com/image.jpg?"
        if (self.dpr > 1) {
            expected += "dpr=" + String(format: "%g", dpr) + "&"
        }
        
        expected += "width=100"

        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUrlWithDpr() {
        let client = ImagizerClient(host: "example.com")
        let url = client.buildUrl("image.jpg", params: ["width": 100, "dpr": 2.5])
        print(url)
        let expected = "http://example.com/image.jpg?dpr=2.5&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUrlWithDefaultDpr() {
        let client = ImagizerClient(host: "example.com")
        client.dpr = 2.4
        let url = client.buildUrl("image.jpg", params: ["width": 100])
        print(url)
        let expected = "http://example.com/image.jpg?dpr=2.4&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUrlWithDprOverride() {
        let client = ImagizerClient(host: "example.com")
        client.dpr = 2.4
        let url = client.buildUrl("image.jpg", params: ["width": 100, "dpr": 3.4])
        print(url)
        let expected = "http://example.com/image.jpg?dpr=3.4&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildurlWithDefaultQuality() {
        let client = ImagizerClient(host: "example.com")
        client.quality = 65
        let url = client.buildUrl("image.jpg", params: ["width": 100])
        print(url)
        let expected = "http://example.com/image.jpg?quality=65&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildurlWithQualityOverride() {
        let client = ImagizerClient(host: "example.com")
        client.quality = 65
        let url = client.buildUrl("image.jpg", params: ["width": 100, "quality": 55])
        print(url)
        let expected = "http://example.com/image.jpg?quality=55&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUrlWithDemoHost() {
        let client = ImagizerClient()
        client.originImageHost = "example.com"
        let url = client.buildUrl("image.jpg", params: ["width": 100])
        print(url)
        let expected = "http://demo.imagizercdn.com/image.jpg?hostname=example.com&width=100"
        XCTAssert(url.absoluteString == expected)
    }
    
    func testBuildUrlWithDemoHostWithScheme() {
        let client = ImagizerClient()
        client.originImageHost = "https://example.com"
        let url = client.buildUrl("image.jpg", params: ["width": 100])
        print(url)
        let expected = "http://demo.imagizercdn.com/image.jpg?hostname=https://example.com&width=100"
        XCTAssert(url.absoluteString == expected)
    }
}
