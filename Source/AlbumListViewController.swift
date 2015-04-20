//
//  FirstViewController.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-13.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit



class AlbumListViewController: UITableViewController {
  
  var albumList : [PhotoAlbum]? = nil
  let rowHeight = 65 as CGFloat
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    
    if !FacebookNetworking.isLoggedIn() {
        let loginController = DSFacebookImagePicker.loginController()
        self.tabBarController?.presentViewController(loginController, animated: true, completion: nil)
    }
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    
    if albumList == nil{
        FacebookNetworking.getAlbumList({ (album, error) in
            if album != nil {
                self.albumList = album!
                self.tableView.reloadData()
            }
        })
    
    tableView.reloadData()
    }
  }
    
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
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
    
    if let thisAlbum = albumList?[indexPath.row]{
      let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath:indexPath) as! AlbumCell
      cell.setUpWithAlbum(thisAlbum)
      return cell
    } else {
      let placeholder = tableView.dequeueReusableCellWithIdentifier("PlaceholderCell", forIndexPath:indexPath) as! UITableViewCell
      return placeholder
    }
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return rowHeight
  }
  
  override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return rowHeight
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let thisAlbum = albumList?[indexPath.row]{
      self .performSegueWithIdentifier("AlbumDetail", sender: thisAlbum)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let segueID = segue.identifier
    
    if(segueID == "AlbumDetail"){
      let thisAlbum = sender as! PhotoAlbum
      let dest = segue.destinationViewController as? PhotoCollectionViewController
      dest?.placeHolderNumber = thisAlbum.count
      dest?.albumID = thisAlbum.albumID
      dest?.title = thisAlbum.name
    }
    
    
  }
  
  
  @IBAction func cancelPressed(sender: AnyObject) {
    if let tabBar = tabBarController as? DSFacebookImagePicker{
      tabBar.cancel()
    }
  }
  
}

