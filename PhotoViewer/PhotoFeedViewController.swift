//
//  ViewController.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedViewController: UIViewController, PhotoFeedViewInterface, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var eventHandler : PhotoFeedViewEventHandler?
    var photos: [Photo]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "PhotoFeedCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PhotoFeedCollectionViewCell")
        
        eventHandler?.viewDidLoad()
    }
    
    // MARK: PhotoFeedViewInterface
    
    func showPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView.reloadData()
    }
    
    func makeIndexVisible(index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false)
    }
    
    func rectForCell(atIndex: Int) -> CGRect {
        let attributes = self.collectionView.layoutAttributesForItem(at: IndexPath(row: atIndex, section: 0))!
        let attributesFrame = attributes.frame
        let frame = self.collectionView.convert(attributesFrame, to: self.collectionView.superview?.superview)
        return frame
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFeedCollectionViewCell", for: indexPath) as! PhotoFeedCollectionViewCell
        
        cell.setPhoto(photo: self.photos![indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        let attributesFrame = attributes?.frame
        let frameToOpenFrom = collectionView.convert(attributesFrame!, to: collectionView.superview?.superview)
        
        self.eventHandler?.photoTapped(fromFrame: frameToOpenFrom, index: indexPath.row)
    }
}

