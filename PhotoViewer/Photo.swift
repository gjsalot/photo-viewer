//
//  Photo.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class Photo: NSObject {
    let imageUrl : String
    let width, height : Int
    
    init(dictionary: NSDictionary) {
        self.imageUrl = dictionary["image_url"] as! String? ?? ""
        self.width = dictionary.object(forKey: "width") as! Int? ?? 0
        self.height = dictionary.object(forKey: "height") as! Int? ?? 0
    }
}
