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
    
    func getPhotoFeedViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.photoFeedViewController = storyboard.instantiateViewController(withIdentifier: "PhotoFeedViewController") as! PhotoFeedViewController
        self.photoFeedPresenter = PhotoFeedPresenter(interactor: photoFeedInteractor, userInterface: self.photoFeedViewController, router: self)
        self.photoFeedViewController.eventHandler = self.photoFeedPresenter
        
        return self.photoFeedViewController
    }
    
    func presentFullscreenPhotoFeed(initialPhotoIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.fullscreenPhotoFeedViewController = storyboard.instantiateViewController(withIdentifier: "FullscreenPhotoFeedViewController") as! FullscreenPhotoFeedViewController
        self.fullscreenPhotoFeedPresenter = FullscreenPhotoFeedPresenter(interactor: photoFeedInteractor, userInterface: self.fullscreenPhotoFeedViewController, router: self, initialPhotoIndex: initialPhotoIndex)
        self.fullscreenPhotoFeedViewController.eventHandler = self.fullscreenPhotoFeedPresenter
        
        self.photoFeedViewController.present(self.fullscreenPhotoFeedViewController, animated: true)
    }
    
    func dismissFullscreenPhotoFeedViewController(finalIndex: Int) {
        self.photoFeedViewController.dismiss(animated: true)
        self.photoFeedPresenter.fullscreenPhotoFeedDismissed(finalPhotoIndex: finalIndex)
    }
}
