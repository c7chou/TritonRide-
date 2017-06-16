//
//  driverConfirmViewController.swift
//  TritonRide
//
//  Created by Ann Chih on 6/6/16.
//  Copyright © 2016 UCSD. All rights reserved.
//

import UIKit

class driverConfirmViewController: UITableViewController {
    let location = CurrentUser.sharedInstance.placeSelected
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var rideLabel: UILabel!
    @IBOutlet weak var pickupTimeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = location
        pickupTimeLabel.text = CurrentUser.sharedInstance.time
        rideLabel.text = "1"
        
    }
    @IBAction func endRide(segue:UIStoryboardSegue) {
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("hello")
    }
    

}
