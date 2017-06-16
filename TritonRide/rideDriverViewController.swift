//
//  rideDriverViewController.swift
//  Uber
//
//  Created by Ann Chih on 6/4/16.
//  Copyright © 2016 Ann Chih. All rights reserved.
//

import UIKit

class rideDriverViewController: UITableViewController {
    var ridePosts:[ridePost] = postData

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridePosts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("driverCell", forIndexPath: indexPath)
                as! driverCell
            
            let driver = ridePosts[indexPath.row] as ridePost
            cell.driver = driver
            return cell
    }
    @IBAction func cancelDriver(segue:UIStoryboardSegue) {
        
    }
}
