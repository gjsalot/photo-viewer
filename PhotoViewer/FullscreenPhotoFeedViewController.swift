//
//  FullscreenPhotoFeedViewController.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class FullscreenPhotoFeedViewController: UIViewController, FullscreenPhotoFeedViewInterface, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var eventHandler : FullscreenPhotoFeedViewEventHandler?
    var photos: [Photo]?
    var collectionViewLoaded = false
    var indexToShowOnLayout : IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: View Lifecycle Calls
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "FullscreenPhotoFeedCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FullscreenPhotoFeedCollectionViewCell")
        
        eventHandler?.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // On view size chance (ex. rotation), ensure the currently visible image remains visible
        self.indexToShowOnLayout = IndexPath(row: self.collectionView.indexPathsForVisibleItems[0].row, section: 0)
    }
    
    override func viewDidLayoutSubviews() {
        updateFlowLayout()
        
        if (!self.collectionViewLoaded) {
            eventHandler?.collectionViewLoaded()
            self.collectionViewLoaded = true
        }
        
        if let indexPath = self.indexToShowOnLayout {
            self.indexToShowOnLayout = nil
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    // MARK: Helper Functions
    
    func updateFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
        self.collectionView.isPagingEnabled = true
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    // MARK: FullscreenPhotoFeedViewInterface
    
    func showPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView.reloadData()
    }
    
    func makeIndexVisible(index: Int) {
        self.indexToShowOnLayout = IndexPath(row: index, section: 0)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullscreenPhotoFeedCollectionViewCell", for: indexPath) as! FullscreenPhotoFeedCollectionViewCell
        
        cell.setPhoto(photo: self.photos![indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        eventHandler?.photoTappedAtIndex(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.eventHandler?.willDisplayPhoto(atIndex: indexPath.row)
    }
}
