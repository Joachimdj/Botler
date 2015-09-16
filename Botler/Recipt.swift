//
//  Recipt.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit


class Recipt {
    let id : String
    let user : String
    let menuItems: String
    let paymentAmount: Double
    let paymentDate: String
    let storeId : String
    
    init(id: String,user: String, menuItems: String, paymentAmount: Double, paymentDate : String, storeId : String) {
        self.id = id
        self.user = user
        self.menuItems = menuItems
        self.paymentAmount = paymentAmount
        self.paymentDate = paymentDate
        self.storeId = storeId
    }
}