//
//  MyPhotosViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-15.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class MyPhotosViewController: PhotoCollectionViewController {

  override func fetchData(){
    
    let maxPhotosOfMe = 100
    
    FacebookNetworking.getImagesFromAlbumID("10152831646314772", photoCount:maxPhotosOfMe, { result, error in
      if result != nil {
        self.photoList = result!
        self.collectionView?.reloadData()
      }
    })
  }
  
  override func viewDidLoad() {
    fetchData()
  }

  @IBAction func cancelPressed(sender: AnyObject) {
    if let tabBar = tabBarController as? DSFacebookImagePicker{
      tabBar.cancel()
    }
  }
}
