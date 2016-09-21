//
//  Router.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class RootRouter: NSObject {
    func showRootViewControllerInWindow(viewController: UIViewController, window: UIWindow)
    {
        let navigationController = window.rootViewController as! UINavigationController
        navigationController.viewControllers = [viewController]
    }
}
