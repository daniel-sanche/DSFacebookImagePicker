//
//  PhotoCollectionViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-14.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class PhotoCollectionViewController:  UICollectionViewController, UICollectionViewDelegateFlowLayout {
  let PhotoSelectedSegue = "SelectPhoto"
  var photoList : [Photo]? = nil
  var albumID : String? {
    didSet{
      fetchData()
    }
  }
  var placeHolderNumber : Int = 30{
    didSet{
      collectionView?.reloadData()
    }
  }
  
  
  func fetchData(){
    if let newID = albumID{
      FacebookNetworking.getImagesFromAlbumID(newID, photoCount:1000, completionHandler: { result, error in
        if result != nil {
          self.photoList = result!
          self.collectionView?.reloadData()
        }
      })
    }
  }

  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let photoCount = photoList?.count{
      return photoCount
    } else {
      return placeHolderNumber
    }
  
  }
  
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

    if let thisPhoto = photoList?[indexPath.row]{
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
      cell.setUpWithPhoto(thisPhoto)
      return cell
    } else {
      let placeholder = collectionView.dequeueReusableCellWithReuseIdentifier("PrototypeCell", forIndexPath: indexPath) as! UICollectionViewCell
      return placeholder
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    let screenWidth = self.view.bounds.width
    let quarterWidth = screenWidth / 4
    return CGSize(width: quarterWidth-3, height: quarterWidth*1.3)
    
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if let selected = photoList?[indexPath.row]{
      self.performSegueWithIdentifier(PhotoSelectedSegue, sender: selected)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let identifier = segue.identifier
    if(identifier == PhotoSelectedSegue){
        if let dest = segue.destinationViewController.topViewController as? PhotoDetailViewController{
            dest.selectedPhoto = sender as? Photo
        }
    }
  }
  
  
  
  
}
