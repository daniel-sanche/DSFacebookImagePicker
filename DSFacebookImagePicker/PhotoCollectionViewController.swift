//
//  PhotoCollectionViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-14.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class PhotoCollectionViewController:  UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var photoList : [Photo]? = nil
  
  
  override func viewDidLoad() {
    FacebookNetworking.getImagesFromAlbumID("10152831646314772", photoCount:100, { result, error in
      if result != nil {
        self.photoList = result!
        self.collectionView?.reloadData()
      }
    })
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let placeHolderNumber = 30
  
    if let photoCount = photoList?.count{
      return photoCount
    } else {
      return placeHolderNumber
    }
  
  }
  
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

    if photoList != nil{
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoCell
      let thisPhoto = photoList![indexPath.row]
      cell.setUpWithPhoto(thisPhoto)
      return cell
    } else {
      let placeholder = collectionView.dequeueReusableCellWithReuseIdentifier("PrototypeCell", forIndexPath: indexPath) as UICollectionViewCell
      return placeholder
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    let screenWidth = self.view.bounds.width
    let quarterWidth = screenWidth / 4
    return CGSize(width: quarterWidth-3, height: quarterWidth*1.3)
    
  }
  
  
}
