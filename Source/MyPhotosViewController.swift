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
    
    FacebookNetworking.getImagesFromAlbumID("10152831646314772", photoCount:maxPhotosOfMe, completionHandler: { result, error in
      if result != nil {
        self.photoList = result!
        self.collectionView?.reloadData()
      }
    })
  }
  
  override func viewDidLoad() {
    

    if !FacebookNetworking.isLoggedIn() {
        let loginController = DSFacebookImagePicker.loginController()
        self.tabBarController?.presentViewController(loginController, animated: true, completion: nil)
    }


  }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.photoList == nil {
            fetchData()
        }
    }

  @IBAction func cancelPressed(sender: AnyObject) {
    if let tabBar = tabBarController as? DSFacebookImagePicker{
      tabBar.cancel()
    }
  }
}
