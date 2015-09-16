//
//  Cats.swift
//  Botler
//
//  Created by Joachim Dittman on 15/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class Cats: UIViewController {

    
    let navigationBar = UIView(frame: CGRectMake(0, 0, screenSize.width, 60))
    let navigationTitle = UILabel()

    var catScroll : UIScrollView?
    var weight:CGFloat = 0
    var height:CGFloat = 0
    var start = 0
    var big = 1
    var count = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //NavigationBar
        
        navigationBar.backgroundColor = UIColor.blackColor().lighterColor()
        
        //NavigationTitle
        navigationTitle.frame = CGRectMake(0, navigationBar.frame.height/2, screenSize.width-20, 25)
        navigationTitle.text = "Bastard cafe"
        navigationTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        navigationTitle.textColor = UIColor.whiteColor()
        navigationTitle.textAlignment = .Center
        navigationBar.addSubview(navigationTitle)
         self.view.addSubview(navigationBar)
        createview()
        
        
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func createview(){
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .Dark)
        
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(blurView)
        // Do any additional setup after loading the view.
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
         
        catScroll = UIScrollView(frame:CGRectMake(0,  60, screenSize.width, screenSize.height))
        catScroll!.backgroundColor = UIColor.lightGrayColor().lighterColor()
       catScroll!.contentInset = UIEdgeInsetsZero;
       
        
        
        println(height)
        catScroll!.scrollEnabled = true
        var images = ["drink","food","beer","dice","vine2","fastFood"]
        
        for (var i=0; i<12; i++)
        {
            var overlay : UIView
            var imageView : UIImageView
            var imageViewIcon : UIImageView
            if(big == 0)
            { //  overlay = UIView(frame:CGRectMake(0, height+10, screenSize.width-20, (screenSize.height/3.5)-20))
               // overlay.backgroundColor = UIColor.blackColor()
               // overlay.alpha = 0.7
                imageView  = UIImageView(frame:CGRectMake(10, height+5, screenSize.width-20, (screenSize.height/5)-10));
                imageView.image = UIImage(named:"img1")
                imageView.alpha = 0.5
                imageViewIcon  = UIImageView(frame:CGRectMake((screenSize.width/3), height+15, (screenSize.width/3)-15, (screenSize.height/5)-30));
                imageViewIcon.image = UIImage(named:"drink")
                height = height + screenSize.height/5
                big = 1
                
              //  imageView.addSubview(overlay)
                
                
                

            }
            else{
            if(start == 0){
                
                imageView  = UIImageView(frame:CGRectMake(10, height+5, (screenSize.width/2)-15, (screenSize.height/4.5)-10));
                imageView.image = UIImage(named:"img3")
                imageView.alpha = 0.5
                imageViewIcon  = UIImageView(frame:CGRectMake(10, height+5, (screenSize.width/2)-20, (screenSize.height/4.5)-10));
                imageViewIcon.image = UIImage(named:"food")
                 
                start = 1
                count++
            }
            
            else
            
            { 
                imageView  = UIImageView(frame:CGRectMake((screenSize.width/2)+5, height+5, (screenSize.width/2)-15, (screenSize.height/4.5)-10));
                imageView.image = UIImage(named:"img2")
                imageView.alpha = 0.5
                imageViewIcon  = UIImageView(frame:CGRectMake((screenSize.width/2), height+5, (screenSize.width/2)-20, (screenSize.height/4.5)-10));
                imageViewIcon.image = UIImage(named:"beer")
                 start = 0
                 height = height + screenSize.height/4.5
                count++
                if(count == 2)
                {
                println("ER 4")
                    big = 0
                }
                
              
            }
       
             
          
        }
                    catScroll?.addSubview(imageView)
            catScroll!.addSubview(imageViewIcon)
        }
        
        catScroll!.contentSize = CGSizeMake(screenSize.width,height)
         self.view.addSubview(catScroll!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    
}
