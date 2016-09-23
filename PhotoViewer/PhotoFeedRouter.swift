//
//  PhotoFeedRouter.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedRouter: NSObject {
    let rootRouter: RootRouter
    let api: Api
    let photoFeedInteractor : PhotoFeedInteractor
    let transitionDelegate = TransitioningDelegate()
    
    weak var photoFeedViewController : PhotoFeedViewController!
    var photoFeedPresenter : PhotoFeedPresenter!
    weak var fullscreenPhotoFeedViewController : FullscreenPhotoFeedViewController!
    var fullscreenPhotoFeedPresenter : FullscreenPhotoFeedPresenter!
    
    init(rootRouter: RootRouter, api: Api) {
        self.rootRouter = rootRouter
        self.api = api
        self.photoFeedInteractor = PhotoFeedInteractor(api: self.api)
    }
    
    func presentRootViewControllerFromWindow(window: UIWindow) {
        self.rootRouter.showRootViewControllerInWindow(viewController: getPhotoFeedViewController(), window: window)
    }
    
    private func getViewControllerFromMainStoryboard(withIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: withIdentifier)
    }
    
    private func getPhotoFeedViewController() -> UIViewController {
        self.photoFeedViewController = getViewControllerFromMainStoryboard(withIdentifier: "PhotoFeedViewController") as! PhotoFeedViewController
        self.photoFeedPresenter = PhotoFeedPresenter(interactor: photoFeedInteractor, userInterface: self.photoFeedViewController, router: self)
        self.photoFeedViewController.eventHandler = self.photoFeedPresenter
        
        return self.photoFeedViewController
    }
    
    func presentFullscreenPhotoFeed(fromFrame: CGRect, initialPhotoIndex: Int) {
        self.fullscreenPhotoFeedViewController = getViewControllerFromMainStoryboard(withIdentifier: "FullscreenPhotoFeedViewController") as! FullscreenPhotoFeedViewController
        self.fullscreenPhotoFeedPresenter = FullscreenPhotoFeedPresenter(interactor: photoFeedInteractor, userInterface: self.fullscreenPhotoFeedViewController, router: self, initialPhotoIndex: initialPhotoIndex)
        self.fullscreenPhotoFeedViewController.eventHandler = self.fullscreenPhotoFeedPresenter
        
        // Setup custom animation with the frame to animate from
        transitionDelegate.openingFrame = fromFrame
        self.fullscreenPhotoFeedViewController.transitioningDelegate = transitionDelegate
        self.fullscreenPhotoFeedViewController.modalPresentationStyle = .custom
        
        self.photoFeedViewController.present(self.fullscreenPhotoFeedViewController, animated: true)
    }
    
    func dismissFullscreenPhotoFeedViewController(finalIndex: Int, loadedMorePhotos: Bool) {
        // Get the frame of the cell for the photo at this index, and tell the animation to use it.
        let closingFrame = self.photoFeedPresenter.fullscreenPhotoFeedDismissedToRect(finalPhotoIndex: finalIndex, loadedMorePhotos: loadedMorePhotos)
        transitionDelegate.closingFrame = closingFrame
        self.photoFeedViewController.dismiss(animated: true)
    }
}
