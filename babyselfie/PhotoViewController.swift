//
//  PhotoViewController.swift
//  babyselfie
//
//  Created by Adam Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var photoName = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = UIImage(named: photoName)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func export(sender: AnyObject) {
        
    }
    
    @IBAction func deleteImage(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}