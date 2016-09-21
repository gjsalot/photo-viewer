//
//  PhotoFeedCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoFeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func setPhoto(photo: Photo) {
        imageView.image = nil
        imageView.af_setImage(withURL: URL(string: photo.imageUrl)!)
    }
}
