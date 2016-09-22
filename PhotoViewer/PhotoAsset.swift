//
//  PhotoSize.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-22.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

enum PhotoSize: Int {
    case cropped440 = 440
    case uncropped1080 = 1080
}

class PhotoAsset: NSObject {
    let url : URL
    let size : PhotoSize
    
    init(dictionary: NSDictionary) {
        self.url = URL(string: dictionary["https_url"] as! String)!
        self.size = PhotoSize.init(rawValue: dictionary["size"] as! Int)!
    }
}
