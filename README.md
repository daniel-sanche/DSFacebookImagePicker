DSFacebookImagePicker
=====================

DSFacebookImagePicker is an image picker replacement that selects photos from the user's Facebook account instead of their local photo library. It was designed to be used as similar as possible to the standard image picker. It was developed in Swift and it should be compatible iOS 7 and above. (Mostly tested on iOS 8, so if there are probelems with 7, let me know)
 

##Installation

DSFacebookImagePicker requires the Facebook SDK. For more information see the [Facebook Documentation](https://developers.facebook.com/docs/ios/getting-started)

An example project has been provided, but because you need a unique Facebook app identifier, it will not be usable until you follow Facebook's tutorials.

Because Cocoapods does not currently properly handle swift projects, you will have to include this in your project the old fashioned way by copying all the files in the "Source" directory to your project.



##Usage

The interface was designed to be as similar to UIImagePickerController as possible

To create a picker:

```
let picker = DSFacebookImagePicker.imagePicker()
picker.imagePickerDelegate = self
presentViewController(picker, animated: true, completion: nil)
```

to handle the resulting image:

```
func facebookImagePicker(picker: DSFacebookImagePicker, didSelectImage: UIImage) {
    let selectedImage = didSelectImage
    dismissViewControllerAnimated(true, completion: nil)
}

```

to handle user cancelation:
```
func facebookImagePickerDidCancel(picker: DSFacebookImagePicker) {
    dismissViewControllerAnimated(true, completion: nil)
}
```

##Screenshots

![Image 1](../blob/feature/edit_about/screenshot1.png?raw=true)

##License

The MIT License (MIT)

Copyright (c) 2014 Daniel Sanche

