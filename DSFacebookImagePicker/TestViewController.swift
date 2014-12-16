//
//  TestViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-16.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, FacebookImagePickerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!

  @IBAction func launchPhotoPicker(sender: AnyObject) {
    let picker = DSFacebookImagePicker.imagePicker()
    picker.imagePickerDelegate = self
    presentViewController(picker, animated: true, completion: nil)
  }
  
  func facebookImagePickerDidCancel(picker: DSFacebookImagePicker) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func facebookImagePicker(picker: DSFacebookImagePicker, didSelectImage: UIImage) {
    imageView.image = didSelectImage
    dismissViewControllerAnimated(true, completion: nil)
  }

}
