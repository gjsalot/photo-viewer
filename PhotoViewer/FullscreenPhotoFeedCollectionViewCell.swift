//
//  FulscreenPhotoFeedCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit
import AlamofireImage

class FullscreenPhotoFeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setPhoto(photo: Photo) {
        imageView.image = nil
        
        // Load the smaller, already cached, image first
        imageView.af_setImage(withURL: photo.assetsBySize[.uncropped256]!.url)
        imageView.af_setImage(withURL: photo.assetsBySize[.uncropped1080]!.url)
    }
}
