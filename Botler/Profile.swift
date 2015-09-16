//
//  Profile.swift
//  OrderNow
//
//  Created by Joachim Dittman on 08/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
import Formulary


class Profile: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up Tab recongizers
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "upAllDrops:")
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(tapRecognizer)
    
        
            //Form creation
            self.form = Form(sections: [
                FormSection(rows: [
                    TextEntryFormRow(name:"Name", tag: "name", validation: RequiredString("Name"), value: "\(realName!)"),
                    TextEntryFormRow(name: "Email", tag: "email", textType: TextEntryType.Email, value: "\(email!)"),
                    TextEntryFormRow(name: "Mobile phone", tag: "mobile", textType: TextEntryType.Number, value: "\(phone!)"),
                    TextEntryFormRow(name: "Password", tag: "password", value: ""),
                    TextEntryFormRow(name: "Gentag password", tag: "repeatPassword", value: "")],
                    name:"Profil"),
                
                FormSection(rows: [
                    FormRow(name:"Gem oplysninger", tag: "save", type: .Button, value: nil, action: { _ in
                        println("Profil gem")
                        let json = values(self.form)
                        let name  = json["name"] as! String
                        let mobile = json["mobile"] as! String
                        let email  = json["email"] as! String
                        let password  = json["password"] as! String
                        let repeatPassword  = json["repeatPassword"] as! String
                        
                        
                        updateUser(name, mobile, email.lowercaseString,  "\(password)",  "\(repeatPassword)", "", { (result) -> Void in
                            
                            if(result == true){
                                Drop.down("Din profil er gemt", state: .Success)
                            }
                            else
                            {
                                Drop.down("Ups noget gik galt. Prøv igen.", state: .Error)
                            }
                        })
                        
                        
                    })
                    ])
                ])
            
   
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func upAllDrops(sender: AnyObject) {
        if let hidden = navigationController?.navigationBarHidden {
            navigationController?.setNavigationBarHidden(!hidden, animated: true)
        }
        
        Drop.upAll()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}



