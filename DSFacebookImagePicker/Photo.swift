//
//  Photo.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-14.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class Photo {
  let photoID : String
  let ownerName : String
  let fullImageURL : NSURL?
  let thumbnailURL : NSURL?
  var thumbnailData : UIImage?
  var imageLoadFailed : Bool
  
  init(json:NSDictionary, fullImageSize:Int=Int.max) {
    let fromDict = json["from"] as [String : String]

    photoID = json["id"] as String
    ownerName = fromDict["name"]!
    imageLoadFailed = false
    
    let imageArray = json["images"] as NSArray
    thumbnailURL = FacebookNetworking.findBestImageURL(imageArray, minImageSize:Int.min)
    fullImageURL = FacebookNetworking.findBestImageURL(imageArray, minImageSize:fullImageSize)    
  }
  
  func loadThumbnail(){
    imageLoadFailed = false
    if self.thumbnailURL == nil{
      imageLoadFailed = true
      return
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      var readError: NSError?
      let data = NSData(contentsOfURL:self.thumbnailURL!, options: nil, error: &readError)
      
      if let error = readError{
        self.imageLoadFailed = true
      } else {
          self.thumbnailData = UIImage(data:data)
      }
      
    })
  }
  
}
