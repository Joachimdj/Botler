//
//  Store.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit


class Store {
    let id : String
    let name : String
    let lat : Double
    let long : Double
    let range : Double
    let image : String
    
    
    init(id: String,name: String, let lat : Double, let long : Double, let range : Double, image:String) {
        self.id = id
        self.name = name
        self.lat = lat
        self.long = long
        self.range = range
        self.image = image
    }
}