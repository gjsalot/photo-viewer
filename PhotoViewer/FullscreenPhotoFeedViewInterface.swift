//
//  FullscreenPhotoFeedViewInterface.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

protocol FullscreenPhotoFeedViewInterface {
    func showPhotos(photos: [Photo])
    func makeIndexVisible(index: Int)
}
