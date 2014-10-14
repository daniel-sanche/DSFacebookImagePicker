//
//  FBLoginViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, FBLoginViewDelegate {
    
    @IBOutlet weak var loginButton: FBLoginView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loginButton.readPermissions = ["user_photos", "friends_photos"];
        
        FBSession.activeSession().requestNewReadPermissions(["user_photos", "friends_photos"], completionHandler: nil);

    }

    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println(loginView)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
