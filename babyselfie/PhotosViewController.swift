//
//  PhotosViewController.swift
//  babyselfie
//
//  Created by Alexander Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import UIKit
import Photos

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageManager = PHCachingImageManager()
    var photos: PHFetchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        
        let width = self.view.frame.size.width/4
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: width, height: width)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        photos = CustomPhotoAlbum.sharedInstance.photos()
        self.collectionView.reloadData()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PhotoSegue" {
            let indexPath = sender as! NSIndexPath
            let photoVC = segue.destinationViewController as! PhotoViewController
            photoVC.asset = self.photos![indexPath.row] as! PHAsset
        }
    }
}

extension PhotosViewController {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos != nil ? photos!.count : 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        let asset = self.photos![indexPath.row] as! PHAsset
        
        let size = cell.frame.size
        imageManager.requestImageForAsset(asset, targetSize: size, contentMode: .AspectFill, options: nil, resultHandler: { (image, info) in
            cell.imageView.image = image
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("PhotoSegue", sender: indexPath)
    }
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
}