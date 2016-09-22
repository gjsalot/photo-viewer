//
//  PhotoFeedViewInterface.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

protocol PhotoFeedViewInterface {
    func showPhotos(photos: [Photo])
    func makeIndexVisible(index: Int)
    func rectForCell(atIndex: Int) -> CGRect
}
