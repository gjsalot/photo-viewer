//
//  PhotoFeedInteractorTests.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-22.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import XCTest

class PhotoFeedInteractorTests: XCTestCase {
    class MockApi : Api {
        var pageSize : Int!
        var page : Int!
        var photosToReturn : [Photo]!
        
        override func get500pxPhotos(pageSize: Int, page: Int, completion: @escaping ([Photo]) -> ()) {
            self.pageSize = pageSize
            self.page = page
            completion(photosToReturn)
        }
    }
    
    var photoFeedInteractor : PhotoFeedInteractor!
    var mockApi : MockApi!
    
    override func setUp() {
        super.setUp()
        
        self.mockApi = MockApi()
        self.photoFeedInteractor = PhotoFeedInteractor(api: self.mockApi)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadMorePhotos() {
        // 36 photos
        self.mockApi.photosToReturn = [PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2,PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2,PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2, PhotoTests.testPhoto1, PhotoTests.testPhoto2]
        
        // Test load more the first time
        self.photoFeedInteractor.loadMorePhotos { (photos) in
            XCTAssert(photos.count == 36)
            XCTAssert(self.mockApi.pageSize == 36)
            XCTAssert(self.mockApi.page == 1)
        }
        
        // Second time the page should increment
        self.photoFeedInteractor.loadMorePhotos { (photos) in
            XCTAssert(photos.count == 72)
            XCTAssert(self.mockApi.pageSize == 36)
            XCTAssert(self.mockApi.page == 2)
        }
    }
    
}
