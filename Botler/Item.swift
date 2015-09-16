//
//  Item.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit


class Item {
    let id : String
    let name : String
    let price : Double
    let cat : String
    let desc : String
    
    
    init(id: String,name: String, let price : Double, let cat : String, desc : String) {
        self.id = id
        self.name = name
        self.price = price
        self.cat = cat
        self.desc = desc
    }
    
    
}