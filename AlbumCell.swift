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
    
    

    func setUpWithAlbum(album:DSPhotoAlbum){
        self.titleLabel?.text = album.name
        
        self.setImage(album)
    }
    
    func setImage(album:DSPhotoAlbum){
        

        if let foundPhoto = album.coverPhoto{
            self.coverImageView?.image = foundPhoto;
        } else if self.coverImageView?.image == nil{
            self.coverImageView?.image = UIImage(named:"dirtblock");
        }
        
        if !album.imageLoadComplete {
            
            let delay = 0.1 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
            dispatch_after(time, dispatch_get_main_queue(), { () in
                self.setImage(album)
            })
        }
    }
    
    

}
