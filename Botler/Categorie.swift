//
//  Categorie.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit


class Categorie {
    let id : String
    let name : String
    let storeId : String
    
    
    init(id: String,name: String, let storeId : String) {
        self.id = id
        self.name = name
        self.storeId = storeId
    }
}