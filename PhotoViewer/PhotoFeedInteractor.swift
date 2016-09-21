//
//  PhotoFeedInteractor.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedInteractor: NSObject {
    private let photosPerPage = 36
    
    private let api : Api
    var photos = [Photo]()
    
    init(api: Api) {
        self.api = api
    }
    
    func loadMorePhotos(completion: @escaping (_ photos: [Photo]) -> ()) {
        let page = photos.count / photosPerPage + 1
        self.api.get500pxPhotos(pageSize: photosPerPage, page: page) { [weak self] (photos) in
            if let strongSelf = self {
                strongSelf.photos.append(contentsOf: photos)
                completion(strongSelf.photos)
            }
        }
    }
}
