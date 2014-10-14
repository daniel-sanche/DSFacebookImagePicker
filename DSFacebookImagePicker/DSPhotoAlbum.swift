//
//  DSPhotoAlbum.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//


class DSPhotoAlbum {
    let name : String
    let URL : NSURL
    let count : Int
    let coverPhotoID : String
    var coverPhoto : UIImage?
    var imageLoadComplete : Bool
    
    init(json:NSDictionary) {
        //println(json)
        name = json["name"] as String
        URL = NSURL.URLWithString(json["link"] as String)
        count = json["count"] as Int
        coverPhotoID = json["cover_photo"] as String
        coverPhoto = nil
        imageLoadComplete = false
        
        //request cover image
        self.recieveCoverImage()

    }
    
    func recieveCoverImage(){
        imageLoadComplete = false
        let request = FBRequest(session: FBSession.activeSession(), graphPath:self.coverPhotoID)
        request.startWithCompletionHandler { (connection, result, error) -> Void in
        
            if error != nil{
                self.imageLoadComplete = true
            } else {
                let entireResult = result as NSDictionary
                let imageArray = entireResult["images"] as NSArray
                
                let bestImageURL = self.findBestImageURL(imageArray)
                if bestImageURL == nil{
                    self.imageLoadComplete = true
                } else {
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        let photoData = NSData(contentsOfURL: bestImageURL!)
                        self.coverPhoto = UIImage(data: photoData)
                        self.imageLoadComplete = true
                    })
                }
            }
        }
    }
    
    private func findBestImageURL(imageOptionsArray:NSArray, minImageSize:Int=100) -> NSURL?{

        
        let sortDescriptor = NSSortDescriptor(key:"height", ascending: true)
        
        let sortedArray = imageOptionsArray.sortedArrayUsingDescriptors([sortDescriptor]) as [NSDictionary]
    
        
        for thisDict in sortedArray{
            let height = thisDict["height"] as Int
            if(height > minImageSize){
                let URLString = thisDict["source"] as String
                return NSURL(string:URLString)
            }
        }
        
        return nil
    }

}
