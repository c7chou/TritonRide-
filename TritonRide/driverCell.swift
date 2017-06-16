//
//  driverCell.swift
//  Uber
//
//  Created by Ann Chih on 6/4/16.
//  Copyright © 2016 Ann Chih. All rights reserved.
//

import UIKit

class driverCell: UITableViewCell {
    @IBOutlet weak var plateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spotLabel: UILabel!

    var driver: ridePost! {
        didSet {
            plateLabel.text = driver.plate
            nameLabel.text = driver.name
            let x:Int = driver.spotAvail!
            let spots = String(x)
            spotLabel.text = "Spots: "+spots
        }
    }
}
