 

import UIKit
import Parse
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UILabel!
    
    // data
    let segues = ["Profil", "Kvitteringer","Log ud"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshUserName:", name:"refreshUserName", object: nil)
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshUserName(notification: NSNotification){
        println("refreshUsername")
        if (userContainer.count>0){
            self.name.text = "\(userContainer[0].name)"
        }
  
 
        
    }
    
    
    // MARK: UITableViewDelegate&DataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segues.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = segues[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
          let nvc =  mainNavigationController()
        if(self.segues[indexPath.row] == "Log ud"){
          
            if let hamburguerViewController = self.findHamburguerViewController() {
                hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
                   NSNotificationCenter.defaultCenter().postNotificationName("LogOut", object: nil)
                    PFUser.logOut()
                    
                })
            }

           
        }   else{
            
         
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
                nvc.visibleViewController.performSegueWithIdentifier(self.segues[indexPath.row], sender: nil)
                hamburguerViewController.contentViewController = nvc
            })
            }
        
        }
    }
    
    // MARK: - Navigation
    
    func mainNavigationController() -> DLHamburguerNavigationController {
        return self.storyboard?.instantiateViewControllerWithIdentifier("DLDemoNavigationViewController") as! DLHamburguerNavigationController
    }
    
}
