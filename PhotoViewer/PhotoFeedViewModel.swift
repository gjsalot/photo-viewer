//
//  PhotoFeedViewModel.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedViewModel: NSObject {
    let photos : [Photo]
    
    init(photos: [Photo]) {
        self.photos = photos
    }
}
