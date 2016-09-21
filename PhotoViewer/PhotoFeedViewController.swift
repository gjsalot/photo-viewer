//
//  ViewController.swift
//  PhotoViewer
//
//  Created by Grant Sutcliffe on 2016-09-20.
//  Copyright © 2016 gjsalot. All rights reserved.
//

import UIKit

class PhotoFeedViewController: UIViewController, PhotoFeedViewInterface {
    var eventHandler : PhotoFeedViewEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventHandler?.viewDidLoad()
    }

}

