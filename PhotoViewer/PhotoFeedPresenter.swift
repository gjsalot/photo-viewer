//
//  PhotoFeedPresenter.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedPresenter: NSObject, PhotoFeedViewEventHandler {
    private let interactor : PhotoFeedInteractor
    private let userInterface : PhotoFeedViewInterface
    private let router : PhotoFeedRouter
    
    init(interactor : PhotoFeedInteractor, userInterface : PhotoFeedViewInterface, router: PhotoFeedRouter) {
        self.interactor = interactor
        self.userInterface = userInterface
        self.router = router
    }
    
    // MARK: PhotoFeedViewEventHandler
    
    func viewDidLoad() {
        self.interactor.loadMorePhotos { [weak self] (photos) in
            self?.userInterface.showPhotos(photos: photos)
        }
    }
    
    func photoTappedAtIndex(index: Int) {
        self.router.presentFullscreenPhotoFeed(initialPhotoIndex: index)
    }
    
    func fullscreenPhotoFeedDismissed(finalPhotoIndex: Int) {
        self.userInterface.showPhotos(photos: self.interactor.photos)
        self.userInterface.makeIndexVisible(index: finalPhotoIndex)
    }
}
