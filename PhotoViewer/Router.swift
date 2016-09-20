//
//  Router.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class Router: NSObject {
    static func getRootViewController() -> UIViewController {
        return UINavigationController(rootViewController: getPhotoFeedViewController())
    }
    
    static func getPhotoFeedViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PhotoFeedViewController") as! PhotoFeedViewController
        let interactor = PhotoFeedInteractor()
        let presenter = PhotoFeedPresenter(interactor: interactor, userInterface: viewController)
        viewController.eventHandler = presenter
        
        return viewController
    }
}
