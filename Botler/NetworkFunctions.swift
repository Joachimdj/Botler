//
//  NetworkFunctions.swift
//  OrderNow
//
//  Created by Joachim Dittman on 27/07/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit 
import Parse


var storeProccess = false
//Create user (PARSE)
//- Send form data from create user form.
func   createUser(name: String,mobileNr: String, email: String, password: String, fbId: String, completion: (result: Int)-> Void){
    println("1")
    //Validation
    if(name == ""){
    completion(result: 2)
    }
    if(email == ""){
        completion(result: 3)
    }
    if(mobileNr == ""){
        completion(result: 4)
    }
    if(password == ""){
        completion(result: 5)
    }
    let emailLow = email.lowercaseString
    println(emailLow)
    if(name != "" && emailLow != "" && mobileNr != "" && password != ""){
    println("2")
    let user = PFUser()
     println("3")
    user.username =  emailLow
     println("4")
    user.password =  password
     println("5")
    user.email = "\(emailLow)"
     println("6")
    user["name"] = "\(name as NSString)"
     println("7")
    user["phone"] = "\(mobileNr as NSString)"
     println("9")
    user["authData"] = "\(fbId as NSString)"
    println("9")

    user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
        if error == nil {
            completion(result: 1)
        } else {
            completion(result: 3)
        }
    }
    }
}


//Update user
func updateUser(name: String,mobile: String, email: String, password: String, repeatPassword: String, fbId: String, completion: (result: Bool)-> Void){
    let user = PFUser.currentUser()
    let emailLow = email.lowercaseString
    println(emailLow)
    user!.username = emailLow
    if(password != "")  { user!.password = password}
    user!.email = emailLow
    user!["name"] = name
    user!["phone"] = mobile
    user!.saveInBackgroundWithBlock{ (succeeded, error) -> Void in
        if error == nil {
            completion(result: true)
        } else {
            completion(result: false)
        }
    }
}


//Login
//- Send email and password
func userLogin(email: String, Password: String, completion: (result: Bool)-> Void){
    let emailLow = email.lowercaseString
    if( emailLow != "" && Password != ""){
    PFUser.logInWithUsernameInBackground(emailLow, password:Password) {
        (user: PFUser?, error: NSError?) -> Void in
        if user != nil {
           var name = user!["name"] as! NSString
           var mobile = user!["phone"] as! NSString
           println(name)
            userContainer.append(User(id: "\(user!.objectId!)", name: "\(name)", mobile:"\(mobile)", email:  "\(user!.email!)"  , fbId: ""))
            // Do stuff after successful login.
            completion(result: true)
            
        } else {
            completion(result: false)
        }
        }
    }
    else
    {
     completion(result: false)
    }
    
    

    
}

//Reset user Password 
func userResetPassword(email: String, completion: (result: Bool)-> Void){
    if(email != ""){
    PFUser.requestPasswordResetForEmailInBackground(email.lowercaseString){ (succeeded, error) -> Void in
        if error == nil {
            completion(result: true)
        } else {
            completion(result: false)
        }
        }
        
    }
    else
    {
        completion(result: false)
    }
    
}

func checkUserExists(email: String, completion: (result: Bool)-> Void)
{
 
    //Parsing Items
    var ReciptsQuery = PFQuery(className:"_User")
    ReciptsQuery.whereKey("email", equalTo:email)
    ReciptsQuery.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]?, error: NSError?) -> Void in
        if  objects!.count != 0{
            // The find succeeded.
            if let objects = objects as? [PFObject] {
            var password = objects[0]["name"] as! String
                println(password)
            }
            
            
            println("Email already exists \(objects!.count)")
            
            completion(result: true)
        } else {
            // Log details of the failure
            completion(result: false)
        }
    }
    
}


// Get stores
func getStores( completion: (result: Bool)-> Void){
    if(storeProccess == false){
        storeProccess == true

    StoreContainer = []
    CategoriesContainer = []
    ItemContainer = []
    
    //Parsing Stores
    var query = PFQuery(className:"Stores")
    query.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]?, error: NSError?) -> Void in
        
        if error == nil {
            // The find succeeded.
            println("Successfully retrieved \(objects!.count) Stores.")
            // Do something with the found objects
            if let objects = objects as? [PFObject] {
                for object in objects {
                    let id = object.objectId!
                    let name = object["name"] as! String
                    let lat = object["lat"] as! Double
                    let long = object["long"] as! Double
                    let image = object["image"] as! String
                    var range = calcDistance(lat, long)
                    println("RANGE\(range)")
                    StoreContainer.append(Store(id: id, name: name,lat:lat, long:long,range:range,image:image))
                }
            }
            //Parsing Categories
            var catQuery = PFQuery(className:"Categories")
            catQuery.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    println("Successfully retrieved \(objects!.count) Categories.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            let id = object.objectId!
                            let name = object["name"] as! String
                            let store = object["store"] as! String
                            
                            CategoriesContainer.append(Categorie(id: id, name: name, storeId: store))
                        }
                    }
                    //Parsing Items
                    var menuItemQuery = PFQuery(className:"MenuItems")
                    menuItemQuery.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            // The find succeeded.
                            println("Successfully retrieved \(objects!.count) MenuItems.")
                            // Do something with the found objects
                            if let objects = objects as? [PFObject] {
                                for object in objects {
                                    let id = object.objectId!
                                    let name = object["name"] as! String
                                    let price = object["price"] as! Double
                                    let cat = object["cat"] as! String
                                    let desc = ""
                                    ItemContainer.append(Item(id: id, name: name, price: price, cat: cat, desc: desc))
                                }
                            }
                            storeProccess = false
                            completion(result: true)
                        } else {
                            // Log details of the failure
                             completion(result: false)
                        }
                    }

                } else {
                    // Log details of the failure
                 completion(result: false)
                }
            }

        } else {
            // Log details of the failure
            completion(result: false)
        }
    }
    
    
    
    
                    
                    
        }
    
}


//Get recipts by currentUser
func getReciptsByUser(userId: NSString,  completion: (result: Bool)-> Void){
    reciptsContainer = []
    
    //Parsing Items
    var ReciptsQuery = PFQuery(className:"Orders")
    ReciptsQuery.whereKey("user", equalTo:userId)
    ReciptsQuery.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]?, error: NSError?) -> Void in
        
        if error == nil {
            // The find succeeded.
            println("Successfully retrieved \(objects!.count) Recipts.")
            // Do something with the found objects
            if let objects = objects as? [PFObject] {
                for object in objects {
                    let id = object.objectId!
                    let user = object["user"] as! String 
                    let menuItems = object["menuItems"] as! String
                    let paymentAmount = object["paymentAmount"] as! Double
                 //   var paymentDate = object["paymentDate"] as! String
                   
                    
                    let store = object["store"] as! String
                 
                    reciptsContainer.append(Recipt(id: id, user: user, menuItems: menuItems, paymentAmount: paymentAmount, paymentDate: "", storeId: store))
                }
            }
            completion(result: true)
        } else {
            // Log details of the failure
            completion(result: false)
        }
    }
    
    
}


//POST ORDER INFO TO DATABASE
func  CreateOrderToParse(itemString: NSString, store:String, currentUser: String,tableNumber: String, accept: Int, paymentAmount: Double, completion: (result: Bool)-> Void){
    
    
     var Object = PFObject(className:"Orders")
         Object.setValue(accept, forKey: "accept")
         Object.setValue(itemString, forKey: "menuItems")
         Object.setValue(store, forKey: "store")
         Object.setValue(currentUser, forKey: "user")
         Object.setValue(paymentAmount, forKey: "paymentAmount")
    
         Object.saveInBackgroundWithBlock { (success, error) -> Void in
        if error == nil {
            if success {
                orderId =  Object.objectId!  
            }
               completion(result: true)
            
        } else {
            completion(result: false)
        }
    }
         }

//POST ORDER INFO TO DATABASE
func  UpdateOrderToParse(objectId: NSString, transactionId: String, accept: Int, paymentDate: String, completion: (result: Bool)-> Void){
    
    
    //Parsing Items
    var query = PFQuery(className: "Orders")
    query.whereKey("objectId", equalTo: objectId)
    query.getFirstObjectInBackgroundWithBlock {
        (object: PFObject?, error: NSError?) -> Void in
        if error != nil || object == nil {
             completion(result: false)
        } else {
            object?.setValue(transactionId, forKey: "transactionId")
            object?.setValue(objectId, forKey: "orderId")
            object?.setValue(accept, forKey: "accept")
            object?.setValue(paymentDate, forKey: "paymentDate")
            object?.saveInBackground()
               completion(result: true)
        }
    }
}




