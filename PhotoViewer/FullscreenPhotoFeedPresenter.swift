//
//  FullscreenPhotoFeedPresenter.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class FullscreenPhotoFeedPresenter: NSObject, FullscreenPhotoFeedViewEventHandler {
    private let interactor : PhotoFeedInteractor
    private let userInterface : FullscreenPhotoFeedViewInterface
    private let router : PhotoFeedRouter
    private let initialPhotoIndex : Int
    
    private var waitingForData = false
    private var loadedMorePhotos = false
    
    init(interactor : PhotoFeedInteractor, userInterface : FullscreenPhotoFeedViewInterface, router: PhotoFeedRouter, initialPhotoIndex: Int) {
        self.interactor = interactor
        self.userInterface = userInterface
        self.router = router
        self.initialPhotoIndex = initialPhotoIndex
    }
    
    // MARK: FullscreenPhotoFeedViewEventHandler
    
    func viewDidLoad() {
        let photos = self.interactor.photos
        self.userInterface.showPhotos(photos: photos)
    }
    
    func viewDidLayoutSubviews() {
        self.userInterface.makeIndexVisible(index: self.initialPhotoIndex)
    }
    
    func photoTappedAtIndex(index: Int) {
        self.router.dismissFullscreenPhotoFeedViewController(finalIndex: index, loadedMorePhotos: self.loadedMorePhotos)
    }
    
    func willDisplayPhoto(atIndex: Int) {
        if (!self.waitingForData && atIndex > self.interactor.photos.count - 3) {
            self.waitingForData = true
            self.loadedMorePhotos = true
            self.interactor.loadMorePhotos(completion: { [weak self] (photos) in
                self?.userInterface.showPhotos(photos: photos)
                self?.waitingForData = false
                })
        }
    }
}
