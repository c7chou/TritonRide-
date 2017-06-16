//
//  PostInformation.swift
//  TritonRide
//
//  Created by Jerry Chou on 6/6/16.
//  Copyright © 2016 UCSD. All rights reserved.
//

import Foundation
import Firebase

struct PostInformation{
    var driver:String?
    var time:String?
    var spots:Int
   // let ref:Firebase?
    
    
    init( driver:String, time:String, spots:Int){
        self.driver = driver
        self.time = time
        self.spots = spots
     //   self.ref = nil
    }
   /* init(snapshot: FDataSnapshot) {
        driver = snapshot.key
        for item in driver.children{
            
        }
        name = snapshot.value["name"] as! String
        addedByUser = snapshot.value["addedByUser"] as! String
        completed = snapshot.value["completed"] as! Bool
        ref = snapshot.ref
    }*/
    
}
