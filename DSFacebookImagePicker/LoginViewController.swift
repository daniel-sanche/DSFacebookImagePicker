//
//  LoginViewController.swift
//  DSFacebookImagePicker
//
//  Created by Daniel Sanche on 2014-12-15.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet weak var loginBtn: FBLoginView!
    
    @IBOutlet weak var textField: UILabel!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        if let permissions = FacebookNetworking.missingPermissions(){
            loginBtn.readPermissions = permissions
        }
        
        loginBtn.delegate = self
        
    }

    @IBAction func cancelPressed(sender: AnyObject) {
        if let picker = self.presentingViewController as? DSFacebookImagePicker{
            picker.dismissViewControllerAnimated(false, completion: { () -> Void in
                picker.cancel()
            })
        }
    }
    
    
    func dismiss(){
        if let picker = self.presentingViewController as? DSFacebookImagePicker{
            picker.dismissViewControllerAnimated(false, completion:nil)
        }
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        self.dismiss()
    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        self.textField.text = error.localizedDescription
    }
    
    
}
