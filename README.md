DSFacebookImagePicker
=====================

DSFacebookImagePicker is an image picker replacement that selects photos from the user's Facebook account instead of their media library. It was designed to be used as similar as possible to the standard image picker. It was developed in Swift for iOS 7 and above.
 

Installation

DSFacebookImagePicker requires the Facebook SDK. For more information see https://developers.facebook.com/docs/ios/getting-started

Because Cocoapods does not currently properly handle swift projects, you will have to clone the repo to use this in a project. Just copy all the files in the "Source" directory.



Usage

The interface was designed to be as similar to UIImagePickerController as possible

To create a picker:

let picker = DSFacebookImagePicker.imagePicker()
picker.imagePickerDelegate = self
presentViewController(picker, animated: true, completion: nil)

to handle success:

func facebookImagePicker(picker: DSFacebookImagePicker, didSelectImage: UIImage) {
    let selectedImage = didSelectImage
    dismissViewControllerAnimated(true, completion: nil)
}

to handle failure:

func facebookImagePickerDidCancel(picker: DSFacebookImagePicker) {
    dismissViewControllerAnimated(true, completion: nil)
}


License

The MIT License (MIT)

Copyright (c) 2014 Daniel Sanche

