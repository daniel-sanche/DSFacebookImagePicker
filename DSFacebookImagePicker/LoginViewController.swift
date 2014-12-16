//
//  LoginViewController.swift
//  DSFacebookImagePicker
//
//  Created by Daniel Sanche on 2014-12-15.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if FacebookNetworking.isLoggedIn(){
            dismiss()
        }
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        if let picker = self.presentingViewController as? DSFacebookImagePicker{
            picker.dismissViewControllerAnimated(false, completion: { () -> Void in
                picker.cancel()
            })
        }
    }
    
    
    @IBAction func loginpressed(sender: AnyObject) {
        FacebookNetworking.logIn { (session, error) -> Void in
            if error == nil {
                self.dismiss()
            } else {
                let alert = UIAlertView(title: "Login Failed", message: error!.localizedDescription, delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }
        }
    }
    
    func dismiss(){
        if let picker = self.presentingViewController as? DSFacebookImagePicker{
            picker.dismissViewControllerAnimated(false, completion:nil)
        }
    }
    
}
