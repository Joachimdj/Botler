//
//  DataManager.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
import Parse

// PUBLIC DATA DIC
var StoreContainer = [Store]()
var FiltredStoreContainer = [Store]()
var CategoriesContainer = [Categorie]()
var ItemContainer = [Item]()
var userContainer = [User]()
var reciptsContainer = [Recipt]()
var filteredItemContainer = [Item]() 
var SelectedMenuItems = [String:Int]()

//PUBLIC DATA VALUES

var Selectedcat = ""
var SelectedStore = ""
var basket = 0.0
var SelectedRecipt = 0
var StoreName = ""
var status = false
var applicationStatus = false
var lat = 0.0
var long = 0.0
var selectedPlace = 0
var placeLat = 0.0
var placeLong = 0.0


//USER DATA
var login = true 
var currentUser = PFUser.currentUser() 
var realName: AnyObject? = currentUser!["name"]
var email: AnyObject? = currentUser?.email!
var phone: AnyObject? = currentUser!["phone"]

//PAYMENT INFO
var orderId = "";
var paymentDate = "";
var itemString = "";
var tableNumberString = "";
var orderStatus = 0;



//PUBLIC INSTANCES
var formatter = NSNumberFormatter()
//let db = SQLiteDB.sharedInstance()
let defaults = NSUserDefaults.standardUserDefaults()
let screenSize: CGRect = UIScreen.mainScreen().bounds


 


 //FUNCTION FOR CALCULATION BASKET
func CalculateBasket() -> Double{
     
    basket = 0.0
    var price = 0.0;
    var amount = 0
   
    for m in SelectedMenuItems
    {
        for item in ItemContainer
        {
            if(item.id == m.0)
            {
                basket += item.price  * Double(m.1)
            }
        }
        
        
    }
    return basket;
}

//FUNCTION FOR EMPTYING BASKET
func emptyBasket(){
    SelectedMenuItems = [String:Int]()
    basket = 0.0
    NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
}

//FUNCTION FOR MAKING DELAYS IN ANIMATIONS
func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

