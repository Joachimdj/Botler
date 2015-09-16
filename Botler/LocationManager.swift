//
//  LocationManager.swift
//  OrderNow
//
//  Created by Joachim Dittman on 02/08/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
import CoreLocation



//FINDS THE CLOEST STORES NEAR USERS CURRENT LOCATION
func FindClosedsStore(userLat: Double,userLong: Double, completion:(storeID:String)-> Void){
    
    var storeID = 0.0
    var closedlat = 0.0
    var myArray = [Double]()
    
    let sortedStores = StoreContainer.sorted { $0.range < $1.range }
    StoreName = StoreContainer[0].name
    completion(storeID: sortedStores[0].id)
}






//CALULATING DISTANCE BETWEEN SHOP AND USERS CURRENT LOCATION
func  calcDistance(latitude: Double, longitude: Double) -> Double{
    
    var unitLocation:CLLocation = CLLocation(latitude: lat, longitude:long)
    
    var storeLocation:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
    
    
    var calcDistance = storeLocation.distanceFromLocation(unitLocation)
    return calcDistance/1000;
}




//REMOVING PART OF A STRING
func PartOfString(s: String, start: Int, length: Int) -> String
{
    return s.substringFromIndex(advance(s.startIndex, start - 1)).substringToIndex(advance(s.startIndex, length))
}