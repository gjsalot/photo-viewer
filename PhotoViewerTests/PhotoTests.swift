//
//  PhotoTests.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-22.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import XCTest

class PhotoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithDictionary() {
        let photo = Photo(dictionary: ["width": 10, "height": 10, "images": [["size": 440, "https_url": "http://google.ca/440"],["size": 1080, "https_url": "http://google.ca/1080"]]])
        XCTAssert(photo.width == 10)
        XCTAssert(photo.height == 10)
        XCTAssert(photo.assetsBySize[.cropped440]!.size == .cropped440)
        XCTAssert(photo.assetsBySize[.cropped440]!.url.absoluteString == "http://google.ca/440")
        XCTAssert(photo.assetsBySize[.uncropped1080]!.size == .uncropped1080)
        XCTAssert(photo.assetsBySize[.uncropped1080]!.url.absoluteString == "http://google.ca/1080")
    }
    
    static func isEqual(photo1: Photo, photo2: Photo) -> Bool {
        for photoAsset in photo1.assetsBySize {
            if let photo2Asset = photo2.assetsBySize[photoAsset.key] {
                if (!PhotoAssetTests.isEqual(photoAsset1: photoAsset.value, photoAsset2: photo2Asset)) {
                    return false
                }
            } else {
                return false
            }
        }
        
        return
            photo1.assetsBySize == photo2.assetsBySize &&
            photo1.height == photo2.height &&
            photo1.width == photo2.width
    }
    
    static let testPhoto1 = Photo(dictionary: ["width": 10, "height": 10, "images": [["size": 440, "https_url": "http://google.ca/440"],["size": 1080, "https_url": "http://google.ca/1080"]]])
    static let testPhoto2 = Photo(dictionary: ["width": 11, "height": 11, "images": [["size": 440, "https_url": "http://google.ca/440"],["size": 30, "https_url": "http://google.ca/30"]]])
    
}
