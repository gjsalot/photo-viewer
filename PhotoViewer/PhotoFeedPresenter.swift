//
//  PhotoFeedPresenter.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedPresenter: NSObject, PhotoFeedViewEventHandler {
    let interactor : PhotoFeedInteractor
    let userInterface : PhotoFeedViewInterface
    
    init(interactor : PhotoFeedInteractor, userInterface : PhotoFeedViewInterface) {
        self.interactor = interactor
        self.userInterface = userInterface
    }
}
