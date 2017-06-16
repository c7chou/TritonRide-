//
//  LoginViewController.swift
//  
//
//  Created by Jerry Chou on 6/5/16.
//
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{

    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var picker: UIPickerView!
    
    
    
    var pickerData:[String] = ["Driver", "Rider"]
    var ref = FIRDatabase.database().reference()
    
    var pickerValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        self.picker.delegate = self
        self.picker.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.txtUsername.endEditing(true)
        self.txtPassword.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
   
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(picker: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(row == 0){
            self.pickerValue = pickerData[0]
        } else{
            self.pickerValue = pickerData[1]
        }
    }

    @IBAction func loginTapped(sender: AnyObject) {
        let email = txtUsername.text
        let password = txtPassword.text
        self.activityIndicator.startAnimating()
        FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
            self.activityIndicator.stopAnimating()
            if let error = error {
                let alertController:UIAlertController = UIAlertController(title: "Login Failed",message: error.localizedDescription , preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default , handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            /*let changeRequest = user?.profileChangeRequest()
            changeRequest!.displayName = user!.email!.componentsSeparatedByString("@")[0]
            changeRequest!.commitChangesWithCompletion(){ (error) in
                self.activityIndicator.stopAnimating()
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                CurrentUser.sharedInstance.uid = user?.uid
                CurrentUser.sharedInstance.email = user?.email
                CurrentUser.sharedInstance.name = user?.displayName
                CurrentUser.sharedInstance.signIn = true
                //self.signedIn(FIRAuth.auth()?.currentUser)
            }*/
            if( self.pickerValue == self.pickerData[1]){
                self.performSegueWithIdentifier("LoggedInRiderSegue", sender: self)
            } else {
                self.performSegueWithIdentifier("LoggedInDriverSegue", sender: self)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
