//
//  PhotoDetailViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-15.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!

  var selectedPhoto : Photo?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = selectedPhoto?.thumbnailData
  }

  @IBAction func cancelPressed(sender: AnyObject) {
    if let presenter = self.presentingViewController{
      presenter.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  
  
  @IBAction func choosePressed(sender: AnyObject) {
    
  }

}
