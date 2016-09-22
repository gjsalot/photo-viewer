//
//  Photo.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class Photo: NSObject {
    let width, height : Int
    let assetsBySize : [PhotoSize : PhotoAsset]
    
    init(dictionary: NSDictionary) {
        self.width = dictionary.object(forKey: "width") as! Int? ?? 0
        self.height = dictionary.object(forKey: "height") as! Int? ?? 0
        
        let assets = dictionary.object(forKey: "images") as! [NSDictionary]
        var assetsBySize = [PhotoSize : PhotoAsset]()
        for asset in assets {
            let photoAsset = PhotoAsset(dictionary: asset)
            assetsBySize[photoAsset.size] = photoAsset
        }
        self.assetsBySize = assetsBySize
    }
}
