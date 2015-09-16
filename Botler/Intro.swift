//
//  Login.swift
//  OrderNow
//
//  Created by Joachim Dittman on 04/09/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//
import UIKit
import DynamicColor
import Parse


class Intro: UIViewController, UITextFieldDelegate, UIScrollViewDelegate   {
    
    
    //INTRO
    let navigationBar = UIView(frame: CGRectMake(0, 0, screenSize.width, 65))
    let navigationTitle = UILabel()
    var scrollView = UIScrollView(frame: CGRectMake(0, 0,screenSize.width, screenSize.height-50))
    let login:UIButton = UIButton(frame: CGRectMake(0, screenSize.height-50, screenSize.width, 50))
    var pageControl = UIPageControl()
    
       override func viewDidLoad() {
 
        //NavigationBar
        
        navigationBar.backgroundColor = UIColor.blackColor().lighterColor()
        
        //NavigationTitle
        navigationTitle.frame = CGRectMake(10, navigationBar.frame.height/2, screenSize.width-20, 20)
        navigationTitle.text = "Botler"
        navigationTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        navigationTitle.textColor = UIColor.whiteColor()
        navigationTitle.textAlignment = .Center
        navigationBar.addSubview(navigationTitle)
        
        // UIScrollView
        println("scrollView.frame = \(scrollView.frame)")
        
        let numImage = 3
        let imageFiles = ["smartPhone", "dollar", "cafe"]
        let pageTitle = ["Spring køen over og", "Betal nemt og hurtigt", "Få leveret ordren"]
        let pageTitle1 = ["vælg cafens varer i Botler", "med MobilePay", "ved bordet"]
        for var i=0; i<numImage; i++ {
            let image = UIImage(named: imageFiles[i])!
            
            var  iView = UIView()
            
            iView.frame.origin = CGPointMake(screenSize.width * CGFloat(i), 0)
            iView.frame.size = CGSizeMake(screenSize.width, screenSize.height/2)
            scrollView.addSubview(iView)
            
            var imageView : UIImageView
            imageView  = UIImageView(frame:CGRectMake(screenSize.width/5.5, screenSize.height/6, screenSize.width/1.5, screenSize.width/1.5));
            imageView.image = UIImage(named:imageFiles[i])
            imageView.alpha = 0.0
            
            UIView.animateWithDuration(1.5, animations: {
                
                imageView.alpha = 1.0
                
                
            })
            iView.addSubview(imageView)
            
            var titleLabel = UILabel(frame:CGRectMake(0, screenSize.height/2+60, screenSize.width, screenSize.width/4))
            titleLabel.textAlignment = .Center
            titleLabel.text = "\(pageTitle[i])"
            iView.addSubview(titleLabel)
            
            var titleLabel1 = UILabel(frame:CGRectMake(0, (screenSize.height/2)+80, screenSize.width, screenSize.width/4))
            titleLabel1.textAlignment = .Center
            titleLabel1.text = "\(pageTitle1[i])"
            iView.addSubview(titleLabel1)
            
        }
        
        var view = UIView()
        let widthImage: CGFloat = self.view.frame.size.width
        let heightImage: CGFloat = 180
        scrollView.contentSize = CGSizeMake(widthImage * CGFloat(numImage), heightImage)
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.view.addSubview(navigationBar)
        
        // UIPageControl
        let heightPageControl = 0
        pageControl.frame = CGRectMake(0, CGFloat(screenSize.height-70), self.view.frame.size.width, CGFloat(heightPageControl))
        pageControl.userInteractionEnabled = false
        pageControl.numberOfPages = numImage
        pageControl.currentPage = 0
        self.view.addSubview(pageControl)
        
        
        
        let originalColor = UIColor(hex: 0xc0392b)
        
        let mixColor = UIColor.greenColor().darkerColor()
        
        //create account
        
        
        //Login button
        
        login.backgroundColor = UIColor.blueColor().lighterColor()
        login.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        login.setTitle("Kom igang", forState: UIControlState.Normal)
        login.addTarget(self, action: "close:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(login)

    }
    
 
   
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    
    
    // UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println("scrollViewDidScroll")
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
          return UIStatusBarStyle.LightContent;
    }
 
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        println("scrollViewDidEndDecelerating")
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
 