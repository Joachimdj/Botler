//
//  ReciptItem.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class ReciptItem: UIViewController {
    var myscr : UIScrollView?
    var myView : UIView?
    var total : UILabel?
    var amount : UILabel?
    var item : UILabel?
    var itemPrice : UILabel?
    var mylbl : UILabel?
    var addItems : UIButton?
    var totalAmount : UILabel?
    var imageView : UIImageView?
    var accountNumber: UITextField!
    var TotalBasketAmount = 0.0
    var reciptStoreName = StoreName
    override func viewDidLoad() {
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        super.viewDidLoad()
        self.createview()
    }
    
    func loadData(completion: (result: Bool)-> Void){
        
    }
  
    func createview(){
        
        // Do any additional setup after loading the view.
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        myscr = UIScrollView()
        myscr!.frame = CGRectMake(0,0,screenWidth,screenHeight)
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
        var string: String = reciptsContainer[SelectedRecipt].menuItems
      
        var array = string.componentsSeparatedByString("|");
       
      for arr in array  {
        println(arr)
       
      
            var string: String = arr
            var newArray = string.componentsSeparatedByString(",");
    
        
        /*
        
        var name = ""
        var price = 20.0
        var amountItem = Double(newArray[0].toInt()!)
        
      
        
        
        
        

            
            amount = UILabel()
            amount!.frame = CGRectMake(5,b,screenWidth-10,0.2)
            amount!.backgroundColor = UIColor.grayColor()
            myscr!.addSubview(amount!)
            
            item = UILabel()
            item!.frame = CGRectMake(10,c,screenWidth-20,14)
            item!.font  = UIFont(name: total!.font.familyName, size: 12)
            
            
            item!.text = "\(name) x \(amountItem) stk. "
            myscr!.addSubview(item!)
            itemPrice = UILabel()
            itemPrice!.frame = CGRectMake(screenWidth-70,c,60,14)
            itemPrice!.font  = UIFont(name: total!.font.familyName, size: 12)
            var finalAmountPrItem = price * amountItem
            TotalBasketAmount  += finalAmountPrItem
            itemPrice!.text = "\(formatter.stringFromNumber(finalAmountPrItem)!)"
            myscr!.addSubview(itemPrice!)
            
            b+=25
            c+=25*/
        
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
        item!.text = "\(formatter.stringFromNumber(TotalBasketAmount)!)"
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
        item!.text = "\(formatter.stringFromNumber(TotalBasketAmount)!)"
        myscr!.addSubview(item!)
        
        
        b+=25
        c+=25
        
        b+=125
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
 
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
}
