//
//  FirstViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit



class AlbumListViewController: UITableViewController {

    var albumList : [DSPhotoAlbum] = [DSPhotoAlbum]()
    let rowHeight = 65 as CGFloat
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if(albumList.count==0){
            DSFacebookNetworking.getAlbumList({ (album, error) in
                if album != nil {
                    self.albumList = album!
                    self.tableView.reloadData()
                }
            })
        }

        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return albumList.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath:indexPath) as UITableViewCell
        
        let thisAlbum = self.albumList[indexPath.row]
        cell.textLabel?.text = thisAlbum.name
        cell.imageView?.image = thisAlbum.coverPhoto
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }



}

