//
//  ViewController.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit
import GreedoLayout

class PhotoFeedViewController: UIViewController, PhotoFeedViewInterface, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GreedoCollectionViewLayoutDataSource {
    var eventHandler : PhotoFeedViewEventHandler?
    var photos: [Photo]?
    
    var collectionViewSizeCalculator : GreedoCollectionViewLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "PhotoFeedCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PhotoFeedCollectionViewCell")
        
        // Setup GreedoCollectionViewLayout
        self.collectionViewSizeCalculator = GreedoCollectionViewLayout(collectionView: self.collectionView)
        self.collectionViewSizeCalculator.dataSource = self
        self.collectionViewSizeCalculator.rowMaximumHeight = self.collectionView.bounds.height / 5;
        self.collectionViewSizeCalculator.fixedHeight = false;
        
        let layout = UICollectionViewFlowLayout();
        layout.minimumInteritemSpacing = 5.0;
        layout.minimumLineSpacing = 5.0;
        layout.sectionInset = UIEdgeInsetsMake(10.0, 5.0, 5.0, 5.0);
        
        self.collectionView.collectionViewLayout = layout;
        
        eventHandler?.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.collectionViewSizeCalculator.clearCache()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: PhotoFeedViewInterface
    
    func showPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView.reloadData()
    }
    
    func makeIndexVisible(index: Int) {
        if (!self.collectionView.indexPathsForVisibleItems.contains(IndexPath(row: index, section: 0))) {
            self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false)
        }
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
        return self.collectionViewSizeCalculator.sizeForPhoto(at: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.eventHandler?.willDisplayPhoto(atIndex: indexPath.row)
    }
    
    // MARK: GreedoCollectionViewLayoutDataSource
    
    func greedoCollectionViewLayout(_ layout: GreedoCollectionViewLayout!, originalImageSizeAt indexPath: IndexPath!) -> CGSize {
        // Return the image size to GreedoCollectionViewLayout
        if (indexPath.row < self.photos!.count) {
            let photo = self.photos![indexPath.row]
            return CGSize(width: photo.width, height: photo.height)
        }
        
        return CGSize(width: 0.1, height: 0.1)
    }
}

