//
//  PhotoDetailViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-15.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

enum LargePhotoState{
  case Active
  case Failed
  case Loading
}

class PhotoDetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!

  var selectedPhoto : Photo?
  var imageState = LargePhotoState.Loading
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = selectedPhoto?.thumbnailData
  
    if let imageURL = selectedPhoto?.fullImageURL{
      loadFullImage(imageURL)
    }
  }
  
  
  func loadFullImage(imageURL:NSURL){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      var readError: NSError?
      let data = NSData(contentsOfURL:imageURL, options: nil, error: &readError)
      
      if let error = readError{
        self.imageState = LargePhotoState.Failed
      } else {
        self.imageView.image = UIImage(data:data)
        self.imageState = LargePhotoState.Active
      }
    })
  }

  @IBAction func cancelPressed(sender: AnyObject) {
    if let presenter = self.presentingViewController{
      presenter.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  
  
  @IBAction func choosePressed(sender: AnyObject) {
    
  }

}
