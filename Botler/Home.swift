//
//  Home.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//


import UIKit
import Parse


class Home: UITableViewController {
    
    
    @IBOutlet weak var topheader: UINavigationItem!
    var filteredCategoriesContainer = [Categorie]()
    
    
    
    override func viewDidLoad() {
        filtreDictonary(SelectedStore)
        super.viewDidLoad()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        topheader.title = "\(StoreName)"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filtreDictonary(storeId : String){
        filteredCategoriesContainer = []
       filteredCategoriesContainer = CategoriesContainer.filter { $0.storeId == storeId }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredCategoriesContainer.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cats", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = filteredCategoriesContainer[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        Selectedcat = filteredCategoriesContainer[indexPath.row].id
        
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
}
