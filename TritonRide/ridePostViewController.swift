//
//  ridePost.swift
//  TritonRide
//
//  Created by Ann Chih on 6/5/16.
//  Copyright © 2016 UCSD. All rights reserved.
//

import UIKit
import Firebase
class ridePostViewController: UITableViewController {
    
    
    let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var spotField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var datePicker: UIDatePicker!
   
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerChanged()
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    @IBAction func cancelPostView(segue:UIStoryboardSegue) {
    }
    
    
    @IBAction func savePostDetail(sender:UIButton) {
        let location = CurrentUser.sharedInstance.placeSelected
        let spots = spotField.text
        let time = timeLabel.text

        let key = self.ref.childByAutoId().key
        let userId = CurrentUser.sharedInstance.email!.componentsSeparatedByString("@")[0]
        self.ref.child(key).child("driver").setValue(userId)
        self.ref.child(key).child("time").setValue(time)
        self.ref.child(key).child("spotAvail").setValue(spots)
        self.ref.child(key).child("location").setValue(location)
        
        
        CurrentUser.sharedInstance.time = timeLabel.text
    }

    func datePickerChanged () {
        timeLabel.text = NSDateFormatter.localizedStringFromDate(datePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleDatepicker()
        }
    }
    var datePickerHidden = false
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    func toggleDatepicker() {
        datePickerHidden = !datePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    @IBAction func datePickerValue(sender: UIDatePicker) {
        datePickerChanged()
    }



        
}
