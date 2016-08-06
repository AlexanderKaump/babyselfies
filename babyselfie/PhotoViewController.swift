//
//  PhotoViewController.swift
//  babyselfie
//
//  Created by Adam Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var asset = PHAsset()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let imageManager = PHCachingImageManager()
        let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        
        imageManager.requestImageForAsset(asset, targetSize: imageSize, contentMode: .AspectFill, options: nil, resultHandler: {(image: UIImage?,
            info: [NSObject : AnyObject]?) in
            self.imageView.image = image
        })
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func export(sender: AnyObject) {
        
        let objectsToShare = [self.imageView.image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteImage(sender: AnyObject) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ 
            PHAssetChangeRequest.deleteAssets([self.asset])
            }) { (success, error) in
                dispatch_async(dispatch_get_main_queue(), { 
                    self.navigationController?.popViewControllerAnimated(true)
                })
        }
    }
}