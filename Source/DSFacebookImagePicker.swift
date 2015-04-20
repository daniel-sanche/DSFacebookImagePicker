//
//  FacebookTabController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-16.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

protocol FacebookImagePickerDelegate {
  func facebookImagePickerDidCancel(picker:DSFacebookImagePicker) -> Void
  func facebookImagePicker(picker:DSFacebookImagePicker, didSelectImage:UIImage) -> Void
}

class DSFacebookImagePicker: UITabBarController{
  
  var imagePickerDelegate:FacebookImagePickerDelegate?
  
  class func imagePicker() -> DSFacebookImagePicker{
    let storyboard = UIStoryboard(name: "FacebookPicker", bundle: nil)
    let picker = storyboard.instantiateViewControllerWithIdentifier("Picker") as! DSFacebookImagePicker
    return picker
  }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fixAppearance()
    }
  
  private func fixAppearance(){
    //set selected tint color
    UITabBar.appearance().selectedImageTintColor = UIColor(white: 1, alpha: 1)
    
    //make it so that the tint color will apply to each image only when it is selected
    for thisItem : UITabBarItem in self.tabBar.items as! [UITabBarItem]{
      if let image = thisItem.image{
        thisItem.selectedImage = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
      }
    }
    
    //set the unselected text color to a slightly different shade
    let unselectedColor = UIColor(white:0.8, alpha: 1)
    UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:unselectedColor], forState: UIControlState.Normal)
    
    //set selected text to white
    UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(white: 1, alpha: 1)], forState: UIControlState.Selected)
  }
  
  internal func cancel(){
    if let delegate = imagePickerDelegate{
      delegate.facebookImagePickerDidCancel(self)
    }
  }
  
  internal func completeWithImage(selected:UIImage){
    if let delegate = imagePickerDelegate{
      delegate.facebookImagePicker(self, didSelectImage:selected)
    }
  }
    
    class func loginController() -> UIViewController{
        let storyboard = UIStoryboard(name: "FacebookPicker", bundle: nil)
        let loginController = storyboard.instantiateViewControllerWithIdentifier("Login") as! UIViewController
        return loginController
    }

}
