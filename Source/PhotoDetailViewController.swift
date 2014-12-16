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
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    activityIndicator.hidden = true
    
    let app = UIApplication.sharedApplication()
    app.networkActivityIndicatorVisible = true
    
    if let thumbnail = selectedPhoto?.thumbnailData{
      imageView.image = selectedPhoto?.thumbnailData
    } else if let thumbnailURL = selectedPhoto?.thumbnailURL {
      self.loadThumbnailImage(thumbnailURL)
    }
    
  
    if let imageURL = selectedPhoto?.fullImageURL{
      loadFullImage(imageURL)
    }
  }
  
  
  func loadFullImage(imageURL:NSURL){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
      var readError: NSError?
      let data = NSData(contentsOfURL:imageURL, options: nil, error: &readError)
      
      let app = UIApplication.sharedApplication()

      
      if let error = readError{
        self.imageState = .Failed
        app.networkActivityIndicatorVisible = false
      } else {
        dispatch_async(dispatch_get_main_queue(), { () in
            if data != nil {
                self.imageView.image = UIImage(data:data!)
            }
          self.imageState = .Active
          app.networkActivityIndicatorVisible = false
        })
      }
    })
  }
  
  func loadThumbnailImage(imageURL:NSURL){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
      var readError: NSError?
      let data = NSData(contentsOfURL:imageURL, options: nil, error: &readError)
      if readError == nil && self.imageView.image==nil && data != nil{
        dispatch_async(dispatch_get_main_queue(), { () in
          self.imageView.image = UIImage(data:data!)
        })
      }
    })
  }

  @IBAction func cancelPressed(sender: AnyObject) {
    if let presenter = self.presentingViewController{
      presenter.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  
  
  @IBAction func choosePressed(sender: AnyObject) {
    //if the large photo is still loading, try again later
    if imageState == .Loading {
      let delay = 0.1 * Double(NSEC_PER_SEC)
      let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
      self.displayActivityIndicator()
      dispatch_after(time, dispatch_get_main_queue(), { () in
        self.choosePressed(sender)
      })
      return
    }
    activityIndicator.hidden = true
    
    if let tabBar = self.presentingViewController as? DSFacebookImagePicker{
      if let selected = self.imageView.image{
       tabBar.completeWithImage(selected)
      }
    }
  }
  
  func displayActivityIndicator(){
    activityIndicator.startAnimating()
    activityIndicator.hidden = false
  }

}
