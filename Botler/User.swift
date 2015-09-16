//
//  User.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit


class User {
    let id : String
    let name : String
    let mobile : String
    let email : String
    let fbId : String
    
    
    init(id: String,name: String, let mobile : String, let email : String, let fbId : String) {
        self.id = id
        self.name = name
        self.mobile = mobile
        self.email = email
        self.fbId = fbId
    }
    
    
}