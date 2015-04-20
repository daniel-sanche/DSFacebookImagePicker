//
//  Photo.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-14.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class Photo {
  let photoID : String?
  let ownerName : String?
  let fullImageURL : NSURL?
  var thumbnailURL : NSURL?
  var thumbnailData : UIImage?
  var imageLoadFailed : Bool
  var isCached : Bool
  
  init(json:NSDictionary, fullImageSize:Int=Int.max) {
    let fromDict = json["from"] as? [String : String]
    
    if let newID = json["id"] as? String{
      photoID = newID
    } else {
        photoID = nil
    }
    if let newName = fromDict?["name"]{
      ownerName = newName
    } else {
        ownerName = nil
    }
    imageLoadFailed = false
    isCached = false
    
    if let imageArray = json["images"] as? NSArray {
      thumbnailURL = FacebookNetworking.findBestImageURL(imageArray, minImageSize:Int.min)
      fullImageURL = FacebookNetworking.findBestImageURL(imageArray, minImageSize:fullImageSize)
    } else {
        thumbnailURL = nil
        fullImageURL = nil
    }
  }
  
  func loadThumbnail(){
    imageLoadFailed = false
    var desiredURL = self.thumbnailURL
    if desiredURL == nil{
      desiredURL = self.fullImageURL
      if desiredURL == nil{
        imageLoadFailed = true
        return
      }
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      var readError: NSError?
      let data = NSData(contentsOfURL:desiredURL!, options: nil, error: &readError)
      
      if let error = readError{
        self.imageLoadFailed = true
      } else if data != nil {
        self.thumbnailData = UIImage(data:data!)
      }
      
    })
  }
  
  func attemptImageCache(){
    if !isCached && thumbnailData != nil{
      let tempDirectory = NSURL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)

      if photoID != nil && tempDirectory != nil{
        let cacheURL = tempDirectory!.URLByAppendingPathComponent(photoID!)
    
        let success = UIImagePNGRepresentation(thumbnailData).writeToURL(cacheURL, atomically: true)
      
        if(success){
          thumbnailURL = cacheURL
          isCached = true
        }
      }
    }
    imageLoadFailed = false
    thumbnailData = nil
  }
  
}
