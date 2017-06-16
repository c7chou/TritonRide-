//
//  rideDriver.swift
//  Uber
//
//  Created by Ann Chih on 6/4/16.
//  Copyright © 2016 Ann Chih. All rights reserved.
//

import UIKit
import Firebase

struct ridePost{
    
    var ref = FIRDatabase.database().reference()
    
    var name: String?
    var plate: String?
    var spotAvail: Int?
    var time: String?
    var rideFinished: Bool?
    var riders:[String]?
    
    init(name: String?, plate: String?, spotAvail:Int, time:String,rideFinished:Bool,riders:[String]) {
        self.name = name
        self.plate = plate
        self.spotAvail = spotAvail
        self.time = time
        self.rideFinished = false
        self.riders = riders
        let dic: Dictionary<String, AnyObject>= ["driver":self.name!,"plate":self.plate!,"spots":self.spotAvail!,"riders":self.riders!,"time":self.time!]
        print("saving to firebase")
        //self.ref.child("tritonride/").setValue(dic)
    }
}
