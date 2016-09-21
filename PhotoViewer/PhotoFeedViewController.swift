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
    var viewModel : PhotoFeedViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "PhotoFeedCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PhotoFeedCollectionViewCell")
        
        eventHandler?.viewDidLoad()
    }
    
    func update(viewModel: PhotoFeedViewModel) {
        self.viewModel = viewModel
        
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFeedCollectionViewCell", for: indexPath) as! PhotoFeedCollectionViewCell
        
        cell.setPhoto(photo: viewModel!.photos[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

