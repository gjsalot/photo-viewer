//
//  PhotoFeedViewEventHandler.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

protocol PhotoFeedViewEventHandler {
    func viewDidLoad()
    func photoTapped(fromFrame: CGRect, index: Int)
    func willDisplayPhoto(atIndex: Int)
}
