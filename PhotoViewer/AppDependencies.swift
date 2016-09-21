//
//  AppDependencies.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-21.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class AppDependencies : NSObject
{
    let photoFeedRouter : PhotoFeedRouter
    let api = Api()
    
    override init()
    {
        let rootRouter = RootRouter()
        
        self.photoFeedRouter = PhotoFeedRouter(rootRouter: rootRouter, api: self.api)
    }
    
    
    func installRootViewControllerIntoWindow(window: UIWindow)
    {
        self.photoFeedRouter.presentRootViewControllerFromWindow(window: window)
    }
}
