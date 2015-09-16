//
//  Recipts.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class Recipts: UITableViewController {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reciptsContainer.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Recipt", forIndexPath: indexPath) as! UITableViewCell
        
        if(reciptsContainer[indexPath.row].id != ""){
            for store in StoreContainer {
                if(store.id == reciptsContainer[indexPath.row].storeId)
                {
                    StoreName = store.name;
                }
            }
            
            cell.textLabel!.text = StoreName}
        var date = reciptsContainer[indexPath.row].paymentDate
        
        cell.detailTextLabel!.text = "\(date)"
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SelectedRecipt =  indexPath.row
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}

