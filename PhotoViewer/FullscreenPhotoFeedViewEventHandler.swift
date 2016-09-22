//
//  FullscreenPhotoFeedViewEventHandler.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

protocol FullscreenPhotoFeedViewEventHandler {
    func viewDidLoad()
    func viewDidLayoutSubviews()
    func photoTappedAtIndex(index: Int)
    func willDisplayPhoto(atIndex: Int)
}
