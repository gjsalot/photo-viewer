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
    
    private var waitingForData = false
    
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
    
    func photoTapped(fromFrame: CGRect, index: Int) {
        self.router.presentFullscreenPhotoFeed(fromFrame: fromFrame, initialPhotoIndex: index)
    }
    
    func fullscreenPhotoFeedDismissedToRect(finalPhotoIndex: Int) -> CGRect {
        self.userInterface.showPhotos(photos: self.interactor.photos)
        self.userInterface.makeIndexVisible(index: finalPhotoIndex)
        
        return self.userInterface.rectForCell(atIndex: finalPhotoIndex)
    }
    
    func willDisplayPhoto(atIndex: Int) {
        if (!self.waitingForData && atIndex > self.interactor.photos.count - 6) {
            self.waitingForData = true
            self.interactor.loadMorePhotos(completion: { [weak self] (photos) in
                self?.userInterface.showPhotos(photos: photos)
                self?.waitingForData = false
            })
        }
    }
}
