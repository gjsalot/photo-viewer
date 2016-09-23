//
//  PhotoAssetTests.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-22.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import XCTest

class PhotoAssetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithDictionary() {
        let photoAsset = PhotoAsset(dictionary: ["size": 440, "https_url": "http://google.ca/440"])
        XCTAssert(photoAsset.size == .cropped440)
        XCTAssert(photoAsset.url.absoluteString == "http://google.ca/440")
        
        let photoAsset2 = PhotoAsset(dictionary: ["size": 1080, "https_url": "http://google.ca/1080"])
        XCTAssert(photoAsset2.size == .uncropped1080)
        XCTAssert(photoAsset2.url.absoluteString == "http://google.ca/1080")
    }
    
    static func isEqual(photoAsset1: PhotoAsset, photoAsset2: PhotoAsset) -> Bool {
        return
            photoAsset1.size == photoAsset2.size &&
            photoAsset1.url.absoluteString == photoAsset2.url.absoluteString
    }
    
}
