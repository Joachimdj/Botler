//
//  Menu.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
var itemId = 0;
var k = 0
class Menu: UITableViewController {
    
    var cellAmount = 0;
    var selectedCellIndexPath = [NSIndexPath]()
    
    @IBOutlet var table: UITableView!
    let SelectedCellHeight: CGFloat = 88.0
    let UnselectedCellHeight: CGFloat = 44.0
    @IBOutlet weak var Basket: UIBarButtonItem!
    override func viewDidLoad() {
        
        super.viewDidLoad()
      filtreDictonary(Selectedcat)
        
        tableView.reloadData()
        println(filteredItemContainer)
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name:"refreshMyTableView", object: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        Basket.title = "Kurv(\(formatter.stringFromNumber(basket)!))"
       
      /*  var shadow = NSShadow()
        shadow.shadowColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        shadow.shadowOffset = CGSizeMake(0, 1)
        var color : UIColor = UIColor(red: 220.0/255.0, green: 104.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        var color1 : UIColor = UIColor(red: 220.0/255.0, green: 104.0/255.0, blue: 1.0/255.0, alpha: 0.1)
        var titleFont : UIFont = UIFont(name: "AmericanTypewriter", size: 12.0)!
        
        var attributes = [
            NSForegroundColorAttributeName : color,
            NSShadowAttributeName : shadow,
            NSFontAttributeName : titleFont,
            NSBackgroundColorAttributeName : color1
        ]
        
        Basket.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        */
    }
    func refreshList(notification: NSNotification){
        SelectedMenuItems = [String:Int]()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count  =  filteredItemContainer.count
        return count + k
        
    }
    
    
     func addSubView(row : Int){
    let screenWidth = screenSize.width
    
    var myView = UIView()
    myView.frame = CGRectMake(0,44,screenWidth,40)
    myView.backgroundColor = UIColor.cyanColor()
    self.tableView.insertSubview(myView, belowSubview: self.tableView)
    
    }
 
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MenuItemCell = tableView.dequeueReusableCellWithIdentifier("MenuItem", forIndexPath: indexPath) as! MenuItemCell
        if(indexPath.row < 9){
        cell.titleLabel.text = filteredItemContainer[indexPath.row].name
        cell.amountLabel.text =  "\(formatter.stringFromNumber(filteredItemContainer[indexPath.row].price)!)"
        cell.subtitleLabel.text = filteredItemContainer[indexPath.row].desc
        var cellAmount1 = 0
    if((SelectedMenuItems[filteredItemContainer[indexPath.row].id]) != nil){
         cellAmount1 = Int(SelectedMenuItems[filteredItemContainer[indexPath.row].id]!)
        cell.amount.text = "\(cellAmount1)"
        
        }
        else
        {
        cell.amount.text = "\(cellAmount1)"
            }
        
        cell.minus.enabled = false
        if(cellAmount1 != 0) {
        
            cell.minus.enabled = true
    }
        
        cell.add.tag = indexPath.row
        cell.minus.tag = indexPath.row
    }
        return cell
        
       
        
    }
    
    
    @IBAction func add(sender: AnyObject) {
       var sender = sender.tag
       addMinusFunction(sender,con: 1)
        println(filteredItemContainer[sender].id)
    }
    @IBAction func minus(sender: AnyObject) {
        var sender = sender.tag
        addMinusFunction(sender,con: 0)
        
    }
    
    func addMinusFunction(sender : Int,con : Int){
          var itemID = filteredItemContainer[sender].id
        var i = 0
        if((SelectedMenuItems[itemID]) != nil){
            var i = Int(SelectedMenuItems[itemID]!)
            if(con==1){ i++} else {i-- }
           
          
            SelectedMenuItems.updateValue(i, forKey: itemID)
        }
        else
        {
           SelectedMenuItems[itemID] = 1
        }
        
         
        //OPDATERE KURV
        CalculateBasket()
        Basket.title = "Kurv(\(formatter.stringFromNumber(basket)!))"
        
        //OPDATERE ROW
        var indexPath = NSIndexPath(forRow: sender, inSection: 0 )
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    
    
    }
    
 
    

   func filtreDictonary(catId : String){
        filteredItemContainer = []
        filteredItemContainer = ItemContainer.filter { $0.cat == catId }
        
        println(filteredItemContainer.count)
   }
 
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}