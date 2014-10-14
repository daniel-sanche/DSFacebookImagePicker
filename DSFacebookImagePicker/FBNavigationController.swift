//
//  FBNavigationController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class FBNavigationController: UINavigationController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        self.setNeedsStatusBarAppearanceUpdate();
        self.navigationBar.tintColor = UIColor(white: 1, alpha: 1)
    }

}
