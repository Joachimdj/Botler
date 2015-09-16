//
//  OrderView.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class OrderView: UIViewController {
   
    @IBOutlet weak var navi: UINavigationBar!
    @IBOutlet weak var tom: UIBarButtonItem!
    var myscr : UIScrollView?
    var mobilePayOn = true
    @IBOutlet weak var goButton: UIButton!
    var myView : UIView?
    var total : UILabel?
    var amount : UILabel?
    var item : UILabel?
    var itemPrice : UILabel?
    var mylbl : UILabel?
    var addItems : UIButton?
    var totalAmount : UILabel?
    var imageView : UIImageView?
    var doneImageView : UIImageView?
    var accountNumber: UITextField!
    var tableNumber: UITextField!
    var done = false
    var TotalBasketAmount = 0.0
    var image: UIImage!
    
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
         navi.barTintColor = UIColor.blackColor().lighterColor()
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "createReciptWindow:", name:"reloadTable", object: nil)
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        super.viewDidLoad()
        
        for m in SelectedMenuItems
        {
            for item in ItemContainer
            {
                if(item.id == m.0)
                {
                    
                    itemString += "\(item.id),\(m.1)|"
                    println(itemString)
                }
            }
            
            
        }
 
        println(itemString)

     
        createview() //calling the method
        
        //createReciptWindow()
        
        
        
    }
    
    
    
   
    func createview(){
      
        // Do any additional setup after loading the view.
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        myscr = UIScrollView()
        myscr!.frame = CGRectMake(0,65,screenWidth,screenHeight-110)
        myscr!.backgroundColor = UIColor.cyanColor()
        myscr!.contentInset = UIEdgeInsetsZero;
        
        
        myscr!.scrollEnabled = true
        self.view.addSubview(myscr!)
        
        
        
        let image = UIImage(named: "basket.png")!
        imageView = UIImageView(image: image)
        imageView!.frame = CGRect(origin: CGPoint(x: 25, y: 0), size:image.size)
        myscr!.addSubview(imageView!)
        
        
        total = UILabel()
        total!.frame = CGRectMake(70,0,250,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 10)
        total!.text = "Total"
        myscr!.addSubview(total!)
        
        totalAmount = UILabel()
        totalAmount!.frame = CGRectMake(70,15,250,30)
        totalAmount!.font  = UIFont(name: total!.font.fontName, size: 20)
        totalAmount!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(totalAmount!)
        
        amount = UILabel()
        amount!.frame = CGRectMake(70,15,250,30)
        amount!.font  = UIFont(name: amount!.font.fontName, size: 20)
        amount!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(amount!)
        
        
        addItems = UIButton()
        addItems!.frame = CGRectMake(screenWidth-70,40,60,45)
        addItems?.backgroundColor = UIColor.lightGrayColor()
        addItems!.setTitle("Ret", forState: UIControlState.Normal)
        addItems!.addTarget(self, action: "close:", forControlEvents: .TouchUpInside)
        myscr!.addSubview(addItems!)
        
        
        item = UILabel()
        item!.frame = CGRectMake(10,40,screenWidth-20,50)
        item!.font  = UIFont(name: total!.font.fontName, size: 32)
        item!.text = "Din bestilling"
        myscr!.addSubview(item!)
        
        var b : CGFloat = 100
        var c : CGFloat = 105
   for menuItem in SelectedMenuItems  {
            
            amount = UILabel()
            amount!.frame = CGRectMake(5,b,screenWidth-10,0.2)
            amount!.backgroundColor = UIColor.grayColor()
            myscr!.addSubview(amount!)
            
            item = UILabel()
            item!.frame = CGRectMake(10,c,screenWidth-20,14)
            item!.font  = UIFont(name: total!.font.familyName, size: 12)
            var name = ""
            var price = 0.0
            for i in ItemContainer
            {
                var selectedID = menuItem.0
                if(i.id == selectedID)
                {
                    name = i.name
                    price = i.price
                }
            }
            var ItemAmount = menuItem.1
            item!.text = "\(name) x \(ItemAmount) stk. "
            myscr!.addSubview(item!)
            
            itemPrice = UILabel()
            itemPrice!.frame = CGRectMake(screenWidth-70,c,60,14)
            itemPrice!.font  = UIFont(name: total!.font.familyName, size: 12)
            var finalAmountPrItem = Double(menuItem.1) * price
            itemPrice!.text = "\(formatter.stringFromNumber(finalAmountPrItem)!)"
            myscr!.addSubview(itemPrice!)
            
            b+=25
            c+=25
      }
        amount = UILabel()
        amount!.frame = CGRectMake(5,b,screenWidth-10,0.5)
        amount!.backgroundColor = UIColor.grayColor()
        myscr!.addSubview(amount!)
        
        
        item = UILabel()
        item!.frame = CGRectMake(10,c,screenWidth-20,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "Subtotal"
        myscr!.addSubview(item!)
        
        item = UILabel()
        item!.frame = CGRectMake(screenWidth-70,c,60,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(item!)
        
        b+=25
        c+=25
        
        amount = UILabel()
        amount!.frame = CGRectMake(5,b,screenWidth-10,1)
        amount!.backgroundColor = UIColor.grayColor()
        myscr!.addSubview(amount!)
        
        item = UILabel()
        item!.frame = CGRectMake(10,c,screenWidth-20,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "Total"
        myscr!.addSubview(item!)
        
        item = UILabel()
        item!.frame = CGRectMake(screenWidth-70,c,60,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(item!)
        
        
        b+=25
        c+=25
        tableNumber = UITextField()
        tableNumber!.frame = CGRectMake(10,b,screenWidth-20,60)
        tableNumber?.backgroundColor = UIColor.whiteColor()
        tableNumber!.placeholder = "Bordnummer"
        
        myscr!.addSubview(tableNumber!)
        b+=75
        c+=25
     
        
        myscr!.contentSize = CGSizeMake(320,b)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func buy(sender: AnyObject) {
        CreateOrderToParse(itemString , SelectedStore, "sdfsdfsdf", "1",1,basket) { (result) -> Void in
            if(self.mobilePayOn == true && orderId != ""){
                var finalBasket: Float = Float(basket)
                buyer().buy(orderId, "Tak for dit køb og nyd din ordre.","\(basket)")}
                
            else
            {
                emptyBasket()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
 
        }
            }
    
    @IBAction func em(sender: AnyObject) {
        emptyBasket()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    func catchPayment(url: NSURL){
   
        MobilePayManager.sharedInstance().handleMobilePayCallbacksWithUrl(url, success: { (orderId, transactionId, signature) -> Void in
            println(" ORDERID \(orderId) transactionId: \(transactionId)")
            
            self.setupReciptWindow(orderId!,transactionId: transactionId)
        }, error: { (orderId, errorCode, errorMessage) -> Void in
           println("ORDERID \(orderId) ERRORCODE \(errorCode) ERRORMESSAGE: \(errorMessage)")
            }) { (orderId) -> Void in
          println("ORDERID \(orderId)")
        }
    }
    
    func setupReciptWindow(orderId: String,transactionId: String){
        createReciptWindow()
    println("\n betaling modtaget \(orderId)")
        let date = NSDate();
        let dateFormatter = NSDateFormatter()
        let localDate = dateFormatter.stringFromDate(date)
       UpdateOrderToParse(orderId, transactionId, 1, localDate) { (result) -> Void in
        println("Database opdateret")
        }
    }
    
    func createReciptWindow(){
        myscr?.removeFromSuperview()
        
        tom.title = ""
        mobilePayOn = false
        goButton.setTitle("Tilbage til menu", forState: UIControlState())
        goButton.backgroundColor = UIColor.greenColor()
        goButton.setTitleColor(UIColor.blackColor(), forState: UIControlState())
        // Do any additional setup after loading the view.
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        myscr = UIScrollView()
        myscr!.frame = CGRectMake(0,44.5,screenWidth,screenHeight-95)
        myscr!.backgroundColor = UIColor.cyanColor()
        myscr!.contentInset = UIEdgeInsetsZero;
        
        
        myscr!.scrollEnabled = true
        self.view.addSubview(myscr!)
        
        
        total = UILabel()
        total!.frame = CGRectMake(screenWidth-105,0,105,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 10)
        total!.text = reciptsContainer[0].paymentDate
        myscr!.addSubview(total!)
        
        total = UILabel()
        total!.frame = CGRectMake(10,0,screenWidth-10,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 25)
        
        total!.text = StoreName
        myscr!.addSubview(total!)
        
        addItems = UIButton()
        addItems!.frame = CGRectMake(screenWidth-120,40,110,45)
        addItems?.backgroundColor = UIColor.lightGrayColor()
        addItems!.setTitle("send pr mail", forState: UIControlState.Normal)
        addItems!.addTarget(self, action: "sendPrMail:", forControlEvents: .TouchUpInside)
        myscr!.addSubview(addItems!)
        
        item = UILabel()
        item!.frame = CGRectMake(10,40,screenWidth-20,50)
        item!.font  = UIFont(name: total!.font.fontName, size: 32)
        item!.text = "Dit køb"
        myscr!.addSubview(item!)
        
        var b : CGFloat = 100
        var c : CGFloat = 105
        for menuItem in SelectedMenuItems  {
            
            amount = UILabel()
            amount!.frame = CGRectMake(5,b,screenWidth-10,0.2)
            amount!.backgroundColor = UIColor.grayColor()
            myscr!.addSubview(amount!)
            
            item = UILabel()
            item!.frame = CGRectMake(10,c,screenWidth-20,14)
            item!.font  = UIFont(name: total!.font.familyName, size: 12)
            var name = ""
            var price = 0.0
            for i in ItemContainer
            {
                var selectedID = menuItem.0
                if(i.id == selectedID)
                {
                    name = i.name
                    price = i.price
                }
            }
            var ItemAmount = menuItem.1
            item!.text = "\(name) x \(ItemAmount) stk. "
            myscr!.addSubview(item!)
            
            itemPrice = UILabel()
            itemPrice!.frame = CGRectMake(screenWidth-70,c,60,14)
            itemPrice!.font  = UIFont(name: total!.font.familyName, size: 12)
            var finalAmountPrItem = Double(menuItem.1) * price
            itemPrice!.text = "\(formatter.stringFromNumber(finalAmountPrItem)!)"
            myscr!.addSubview(itemPrice!)
            
            b+=25
            c+=25
        }
        amount = UILabel()
        amount!.frame = CGRectMake(5,b,screenWidth-10,0.5)
        amount!.backgroundColor = UIColor.grayColor()
        myscr!.addSubview(amount!)
        
        
        item = UILabel()
        item!.frame = CGRectMake(10,c,screenWidth-20,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "Subtotal"
        myscr!.addSubview(item!)
        
        item = UILabel()
        item!.frame = CGRectMake(screenWidth-70,c,60,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(item!)
        
        b+=25
        c+=25
        
        amount = UILabel()
        amount!.frame = CGRectMake(5,b,screenWidth-10,1)
        amount!.backgroundColor = UIColor.grayColor()
        myscr!.addSubview(amount!)
        
        item = UILabel()
        item!.frame = CGRectMake(10,c,screenWidth-20,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "Total"
        myscr!.addSubview(item!)
        
        item = UILabel()
        item!.frame = CGRectMake(screenWidth-70,c,60,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(item!)
        
         
        b+=75
        c+=25
        
        
        myscr!.contentSize = CGSizeMake(320,b)
    
    }
 

    
    /*
    func goToPayment(sender:UIButton!) {
        // myscr?.removeFromSuperview()
        // createPaymentWindow()
        
        var name = "Kurv indhold"
        var image = UIImage(named:"basket.png")
        var recieptMessage = "Thanks for your payment"
        // MobilePayCrossOver().Buying("\(formatter.stringFromNumber(basket)!)", orderId: "dl20xll1sls03l")
        
        
        SwiftSpinner.show("Afventer cafeens svar...", animated: true, image: false)
        
        //CREATING ORDER IN DATABASE AND CONTACTING THE CAFE
        
        println("INFO POSTET TO DATABASE")
        postOrderInfoToDatabase(itemString, UserId, tableNumberString) { (result) -> Void in
            
            println("Wating of order acceptence from the cafe")
            self.CheckDatabaseForAcceptence(1)
            
        }
        
        
        
        // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func handleTimer(timer: NSTimer) {
        if(done == true){
            timer.invalidate()
            println("timer")
        }
        else{
            println("timer")
            self.CheckDatabaseForAcceptence(2)}
        
        println("HEJ\(orderStatus)")
    }
    
    
    func CheckDatabaseForAcceptence(status:Int)
    {
        watingForAcceptOrderFromDatabase(orderId1,status, { (result) -> Void in
            
            
            if(result==true){
                if(orderStatus == 1){
                    SwiftSpinner.show("Din ordre er igang...", animated: true, image: false)
                    delay(seconds: 1, { () -> () in
                        
                        self.createReciptWindow()
                        
                        delay(seconds: 2, { () -> () in
                            SwiftSpinner.hide()
                            
                        })
                    })
                }
                
                if(orderStatus == 2){
                    println("DONE")
                    var localNotification = UILocalNotification()
                    localNotification.fireDate = NSDate(timeIntervalSinceNow: 2)
                    localNotification.alertBody = "Din ordre er klar"
                    localNotification.timeZone = NSTimeZone.defaultTimeZone()
                    localNotification.applicationIconBadgeNumber = 1
                    localNotification.soundName = UILocalNotificationDefaultSoundName;
                    localNotification.alertAction = "View"
                    UIApplication.sharedApplication().applicationIconBadgeNumber = 1
                    
                    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                    self.done = true
                    orderStatus = 3
                }
                
            }
            else
            {
                delay(seconds: 5, { () -> () in
                    if(status == 1){
                        
                        self.CheckDatabaseForAcceptence(1)
                        
                    }
                    if(status == 2){
                        
                        self.CheckDatabaseForAcceptence(2)
                    }
                })
            }
            
        })
    }
      */
    


}
