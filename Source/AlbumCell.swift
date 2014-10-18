//
//  AlbumCell.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-14.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
  
  @IBOutlet weak var coverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func prepareForReuse() {
    coverImageView?.image = UIImage(named:"albumPlaceholder")
  }
  
  func setUpWithAlbum(album:PhotoAlbum){
    titleLabel?.text = album.name
    setImage(album)
  }
  
  private func setImage(album:PhotoAlbum){
    if let foundPhoto = album.coverPhoto{
      coverImageView?.image = foundPhoto
    } else if !album.imageLoadFailed {
      
      let delay = 0.1 * Double(NSEC_PER_SEC)
      let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
      
      dispatch_after(time, dispatch_get_main_queue(), { () in
        self.setImage(album)
      })
    }
  }
  
  
  
}
