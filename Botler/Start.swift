//
//  DLDemoMainContentViewController.swift
//  DLHamburguerMenu
//
//  Created by Nacho on 5/3/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit
import CoreLocation
import PermissionScope
import Parse
import Haneke
import SwiftSpinner


class Start: UIViewController, CLLocationManagerDelegate {
     
   
    @IBOutlet weak var tableview: UITableView!
    let navigationBar = UIView(frame: CGRectMake(0, 0, screenSize.width, 65))
    let navigationTitle = UILabel()
    let DismissButton = UIButton()
    
    var locationManager: CLLocationManager!
    let multiPscope = PermissionScope()
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    
    override func viewDidLoad() {
        
 
        
     
                 navigationController!.navigationBar.barTintColor = UIColor.blackColor().lighterColor()
   
        super.viewDidLoad()
        
       
        
      
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logOut:", name:"LogOut", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable:", name:"reloadTable", object: nil)
        applicationStatus == true
        if(applicationStatus == false){
            multiPscope.addPermission(PermissionConfig(type: .LocationInUse, demands: .Required, message: "Vi bruger din lokation til \r\nfinde den nærmeste cafe"))
            multiPscope.addPermission(PermissionConfig(type: .Notifications, demands: .Optional, message: "Vi bruger det til at fortælle dig\r\n hvornår din ordre er færdig", notificationCategories: .None))
            multiPscope.show(authChange: { (finished, results) -> Void in
                
                self.locationManager = CLLocationManager()
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                
                
                }, cancelled: { (results) -> Void in
                    println("thing was cancelled")
            })
            
        }
        if(status == false){
            self.initLocationManager { (result) -> Void in
                println(result)
            }
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        SelectedStore = "0"
        
        
      
    }
    // Location Manager helper stuff
    func initLocationManager(completion:(result:Bool)-> Void){
        
    }
    
    // Location Manager Delegate stuff
    // If failed
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation
            var coord = locationObj.coordinate
            lat = coord.latitude
            long = coord.longitude
            println("LOCATION SET \(lat),\(long)")
            applicationStatus == true
            
        }
    }
    
    // authorization status
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
                locationManager.requestAlwaysAuthorization()
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
                locationManager.requestAlwaysAuthorization()
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
                locationManager.requestAlwaysAuthorization()
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
                getStartData()
                
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }
    func findLocation(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.initLocationManager { (result) -> Void in
            println(result)
        }
    }
    
    func getStartData(){
        
                    getStores({ (result) -> Void in
                if(result == true){println("1.Stores, categories and items loaded")} else {println("1.error")}
                
                FindClosedsStore(lat, long, { (storeID) -> Void in
                    if(result == true){
                        println("2.Stores where sortet")
                        SelectedStore = StoreContainer[0].id
                        
                        var storeCount = 0
                        for store in StoreContainer
                        {
                            if(store.range > 2)
                            {
                            storeCount++
                            }
                        
                        }
                        if(SelectedStore != "" && storeCount==1)
                        {
                           self.performSegueWithIdentifier("Home", sender: self)
                        }
                        self.tableview.reloadData()
                        self.locationManager.stopUpdatingLocation()
                    }
                    else
                    {
                        println("2.error")
                    }
                
            })
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logOut(notification: NSNotification){
        var VC1 = self.storyboard?.instantiateViewControllerWithIdentifier("Intro") as! Intro
        presentViewController(VC1, animated:true, completion: nil)
        
    }
   
    func reloadTable(notification: NSNotification){
        self.tableview.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoreContainer.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: StartTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StartTableViewCell
        
      let url = NSURL(string:StoreContainer[indexPath.row].image)
     cell.headerImage.hnk_setImageFromURL(url!) 
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SelectedStore = StoreContainer[indexPath.row].id
        StoreName = StoreContainer[indexPath.row].name
        emptyBasket()
    }
    
    
    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
 
}
