//
//  AppDelegate.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        let wasHandled = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        return wasHandled
    }

}

