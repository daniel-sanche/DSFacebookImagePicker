//
//  FirstViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit



class AlbumListViewController: UITableViewController {

    var albumList : [DSPhotoAlbum]? = nil
    let rowHeight = 65 as CGFloat
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if albumList == nil{
            DSFacebookNetworking.getAlbumList({ (album, error) in
                if album != nil {
                    self.albumList = album!
                    self.tableView.reloadData()
                }
            })
        }

        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let placeHolderNumber = 10
        
        if let albumCount = albumList?.count{
            return albumCount
        } else {
            return placeHolderNumber
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if albumList != nil{
        
            let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath:indexPath) as AlbumCell
            let thisAlbum = albumList?[indexPath.row]
            cell.setUpWithAlbum(thisAlbum!)
            return cell;
        } else {
            let placeholder = tableView.dequeueReusableCellWithIdentifier("PlaceholderCell", forIndexPath:indexPath) as UITableViewCell
            return placeholder
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }



}

