//
//  ViewController.swift
//  babyselfie
//
//  Created by Alexander Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
}

