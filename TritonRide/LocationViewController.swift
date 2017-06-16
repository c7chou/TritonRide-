//
//  LocationViewController.swift
//  Uber
//
//  Created by Ann Chih on 4/23/16.
//  Copyright © 2016 Ann Chih. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI
import GoogleMaps
import Firebase

class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var geoCoder:CLGeocoder!
    var locationManager: CLLocationManager!
    var previousAddress: String!
    var placePicker: GMSPlacePicker?
    
    @IBAction func cancelGetRide(segue:UIStoryboardSegue) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self
        self.mapView.showsUserLocation = true

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        //Get user's current location once, called multiple times
        locationManager.requestLocation()
        
        geoCoder = CLGeocoder()
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                CurrentUser.sharedInstance.name = user.displayName
                CurrentUser.sharedInstance.signIn = true
                CurrentUser.sharedInstance.email = user.email
                CurrentUser.sharedInstance.uid = user.uid
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
        self.mapView.centerCoordinate = location.coordinate
        let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 50, 50)
        self.mapView.setRegion(reg, animated: true)
        geoCode(location)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        geoCode(location)
    }
    
    func geoCode(location : CLLocation!){
        /* Only one reverse geocoding can be in progress at a time hence we need to cancel existing
         one if we are getting location updates */
        geoCoder.cancelGeocode()
        
         //Translates latitude and longtitude to address, state format
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(data,error) -> Void in
            
            guard let placeMarks = data as [CLPlacemark]! else{
                return
            }
            //CLPlacemark stroes placemark data (country, state, street address) associated with a coordination
            let loc: CLPlacemark = placeMarks[0]
            //A dictionary conatining the Address Book keys and values for the placemark
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            let address = addrList.joinWithSeparator(", ")
            print(address)
            self.address.text = address
            self.previousAddress = address
        })
        
    }
    
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        let region = MKCoordinateRegionMakeWithDistance(locationManager.location!.coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func pickPlace(sender: UIButton) {
        let center = CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        placePicker = GMSPlacePicker(config: config)
        
        placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
            
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            if let place = place {
                print("Place name \(place.name)")
                print("Place address \(place.formattedAddress)")
                print("Place attributions \(place.attributions)")
                CurrentUser.sharedInstance.placeSelected = place.name
            } else {
                print("No place selected")
            }
        })
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
