//
//  FacebookNetworking.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class FacebookNetworking: NSObject {
    
    
     class func getAlbumList(completionHandler:([PhotoAlbum]?, NSError?)->()){
    
        //attempt log in
        if(!isLoggedIn()){
            logIn({ (session, error) -> Void in
                if error != nil{
                    completionHandler(nil, error)
                } else {
                    self.getAlbumList(completionHandler)
                }
            })
            return
        }
    
    

        FBRequestConnection.startWithGraphPath("me/albums", {connection, result, error in

        if let json = result as? NSDictionary{
            
            
            var albumList = [PhotoAlbum]()
            
            for thisAlbumDict in json.objectForKey("data") as NSArray{
                let newAlbum = PhotoAlbum(json:thisAlbumDict as NSDictionary)
                albumList.append(newAlbum)
            }
            
            completionHandler(albumList, error)
            
        } else {
            completionHandler(nil, error)
        }
    

        
        })
    }
    
    
    class func missingPermissions() -> [String]?{

        var permissions : [String] = [String]()
        
        let currentPermissions : [String] = FBSession.activeSession().permissions as [String]
        
        let requiredPerimissions = ["user_photos"]
        
        for thisPermission in requiredPerimissions{
            if(!contains(currentPermissions, thisPermission)){
                permissions.append(thisPermission)
            }
        }
        if(permissions.isEmpty){
            return nil
        } else {
            println(permissions)
            return permissions
        }
    }
    
    class func isLoggedIn() -> Bool{
        let session = FBSession.activeSession()
        if(!session.isOpen){
            return false
        } else if missingPermissions() != nil{
            return false
        } else {
            return true
        }
    }
    
    class func logIn(handler:FBSessionRequestPermissionResultHandler){
        
        let session = FBSession.activeSession()
        
        if(session.isOpen){
            if let permissions = missingPermissions(){
                FBSession.activeSession().requestNewReadPermissions(permissions, handler)
            }
        } else {
            FBSession.openActiveSessionWithReadPermissions(missingPermissions(), allowLoginUI:true, completionHandler: { session, state, error in
                handler(session, error)
            })
        }
    }
    
    
    
    
}
