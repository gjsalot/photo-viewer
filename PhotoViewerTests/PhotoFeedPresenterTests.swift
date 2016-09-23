//
//  PhotoViewerTests.swift
//  PhotoViewerTests
//
//  Created by Grant Sutcliffe on 2016-09-22.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import XCTest

class PhotoFeedPresenterTests: XCTestCase {
    class MockApi : Api {
        
    }
    class MockRootRouter : RootRouter {
        
    }
    class MockPhotoFeedInteractor: PhotoFeedInteractor {
        var photosToReturn : [Photo]!
        
        override func loadMorePhotos(completion: @escaping ([Photo]) -> ()) {
            completion(self.photosToReturn)
        }
    }
    class MockPhotoFeedViewInterface: PhotoFeedViewInterface {
        var photosLastShown : [Photo]?
        
        func showPhotos(photos: [Photo]) {
            self.photosLastShown = photos
        }
        
        func makeIndexVisible(index: Int) {
            
        }
        
        func rectForCell(atIndex: Int) -> CGRect {
            return .zero
        }
    }
    class MockPhotoFeedRouter: PhotoFeedRouter {
        var fromFrame : CGRect!
        var initialPhotoIndex : Int!
        
        override func presentFullscreenPhotoFeed(fromFrame: CGRect, initialPhotoIndex: Int) {
            self.fromFrame = fromFrame
            self.initialPhotoIndex = initialPhotoIndex
        }
    }
    
    var photoFeedPresenter : PhotoFeedPresenter!
    var mockPhotoFeedInteractor : MockPhotoFeedInteractor!
    var mockPhotoFeedViewInterface : MockPhotoFeedViewInterface!
    var mockPhotoFeedRouter : MockPhotoFeedRouter!
    var mockRootRouter : MockRootRouter!
    var mockApi : MockApi!
    
    override func setUp() {
        super.setUp()
        
        self.mockApi = MockApi()
        self.mockRootRouter = MockRootRouter()
        self.mockPhotoFeedInteractor = MockPhotoFeedInteractor(api: self.mockApi)
        self.mockPhotoFeedViewInterface = MockPhotoFeedViewInterface()
        self.mockPhotoFeedRouter = MockPhotoFeedRouter(rootRouter: self.mockRootRouter, api: self.mockApi)
        self.photoFeedPresenter = PhotoFeedPresenter(interactor: self.mockPhotoFeedInteractor, userInterface: self.mockPhotoFeedViewInterface, router: self.mockPhotoFeedRouter)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewDidLoadNoPhotos() {
        self.mockPhotoFeedInteractor.photosToReturn = []
        self.photoFeedPresenter.viewDidLoad()
        XCTAssert(self.mockPhotoFeedViewInterface.photosLastShown?.count == 0)
    }
    
    func testViewDidLoadPhotos() {
        self.mockPhotoFeedInteractor.photosToReturn = [PhotoTests.testPhoto1, PhotoTests.testPhoto2]
        self.photoFeedPresenter.viewDidLoad()
        XCTAssert(self.mockPhotoFeedViewInterface.photosLastShown?.count == 2)
        XCTAssert(PhotoTests.isEqual(photo1: self.mockPhotoFeedViewInterface.photosLastShown![0], photo2: PhotoTests.testPhoto1))
        XCTAssert(PhotoTests.isEqual(photo1: self.mockPhotoFeedViewInterface.photosLastShown![1], photo2: PhotoTests.testPhoto2))
    }
    
    func testPhotoTapped() {
        let fromFrame = CGRect(x: 1, y: 2, width: 3, height: 4)
        self.photoFeedPresenter.photoTapped(fromFrame: fromFrame, index: 7)
        XCTAssert(self.mockPhotoFeedRouter.fromFrame.equalTo(fromFrame))
        XCTAssert(self.mockPhotoFeedRouter.initialPhotoIndex == 7)
    }
    
    func testWillDisplayPhotoShouldLoadMore() {
        self.mockPhotoFeedInteractor.photos = [PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1]
        self.mockPhotoFeedInteractor.photosToReturn = [PhotoTests.testPhoto2]
        self.mockPhotoFeedViewInterface.photosLastShown = []
        self.photoFeedPresenter.willDisplayPhoto(atIndex: 4)
        XCTAssert(PhotoTests.isEqual(photo1: self.mockPhotoFeedViewInterface.photosLastShown![0], photo2: PhotoTests.testPhoto2))
    }
    
    func testWillDisplayPhotoShouldNotLoadMore() {
        self.mockPhotoFeedInteractor.photos = [PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1, PhotoTests.testPhoto1]
        self.mockPhotoFeedInteractor.photosToReturn = [PhotoTests.testPhoto2]
        self.mockPhotoFeedViewInterface.photosLastShown = []
        self.photoFeedPresenter.willDisplayPhoto(atIndex: 4)
        XCTAssert(self.mockPhotoFeedViewInterface.photosLastShown?.count == 0)
    }
    
}
