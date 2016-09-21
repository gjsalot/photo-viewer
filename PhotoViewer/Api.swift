//
//  Api.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit
import Alamofire

class Api: NSObject {
    func get500pxPhotos(count: Int, offset: Int, completion: @escaping (_ photos: [Photo]) -> ()) {
        let url = "https://api.500px.com/v1/photos"
        let parameters : Parameters = [
            "feature" : "popular",
            "image_size": 440,
            "consumer_key": "GZNieDdpg0cYPHe52kRK1OmWQYvPX3rYxtt98Ajh",
            "rpp": count,
            "offset": offset
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    
                    if let photos = response["photos"] {
                        let photos = photos as! [NSDictionary]
                        completion(photos.map { Photo(dictionary: $0) })
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
}
