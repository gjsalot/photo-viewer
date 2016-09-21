//
//  PhotoFeedInteractor.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedInteractor: NSObject {
    let api : Api
    
    init(api: Api) {
        self.api = api
    }
    
    func getPhotos(count: Int, offset: Int, completion: @escaping (_ photos: [Photo]) -> ()) {
        Api().get500pxPhotos(count: count, offset: offset) { (photos) in
            completion(photos)
        }
    }
}
