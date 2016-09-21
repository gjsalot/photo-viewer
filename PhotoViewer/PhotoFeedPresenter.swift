//
//  PhotoFeedPresenter.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedPresenter: NSObject, PhotoFeedViewEventHandler {
    let photosPerPage = 36
    
    let interactor : PhotoFeedInteractor
    let userInterface : PhotoFeedViewInterface
    var photos = [Photo]()
    
    init(interactor : PhotoFeedInteractor, userInterface : PhotoFeedViewInterface) {
        self.interactor = interactor
        self.userInterface = userInterface
    }
    
    func viewDidLoad() {
        interactor.getPhotos(count: 36, offset: 0) { (photos) in
            self.photos.append(contentsOf: photos)
        }
    }
}
