//
//  postCell.swift
//  TritonRide
//
//  Created by Ann Chih on 6/7/16.
//  Copyright © 2016 UCSD. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var driverSlot: UILabel!
    @IBOutlet weak var timeSlot: UILabel!
    @IBOutlet weak var spotSlot: UILabel!
    @IBOutlet weak var locationSlot: UILabel!
    
    var postings:Post!{
        didSet{
            
            driverSlot.text = postings.driver
            
            timeSlot.text = postings.time;
            spotSlot.text = String(postings.spots).componentsSeparatedByString("\"")[1]
            locationSlot.text = postings.location
            
        }
        
    }
}
