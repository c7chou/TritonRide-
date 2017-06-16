//
//  CurrentUser.swift
//  TritonRide
//
//  Created by Jerry Chou on 6/5/16.
//  Copyright © 2016 UCSD. All rights reserved.
//

import Foundation
import Firebase

class CurrentUser:NSObject {
    
    static let sharedInstance = CurrentUser()
    
    var uid: String? = nil
    var email: String? = nil
    var name: String? = nil
    var signIn: Bool = false
    var placeSelected: String? = nil
    var time: String? = nil
}
