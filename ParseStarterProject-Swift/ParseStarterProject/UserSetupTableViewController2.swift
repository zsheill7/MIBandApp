import UIKit
import Parse
import Mixpanel

class UserSetupTableViewController2: UITableViewController {
    
    var user = PFUser.currentUser()
    
    var downArrow = UIButton(type: .System)
    var upArrow = UIButton(type: .System)
    
    @IBOutlet weak var isAdmin: UISwitch!
    
    @IBOutlet weak var isSectionLeader: UISwitch!
    
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                //self.dismissViewControllerAnimated(true, completion: nil)
                
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            print("error")
        }
        
        
        
    }
    
    override func viewDidLoad() {
        let totalHeight = self.tableView.frame.size.height + 65
        if  totalHeight > self.view.frame.size.height {
            downArrow = UIButton(frame: CGRect(x: self.view.frame.size.width - 50, y: self.view.frame.size.height - 100, width: 50, height: 50))
            downArrow.tag = 1
            downArrow.setImage(UIImage(named: "down"), forState: .Normal)
            downArrow.addTarget(self, action: #selector(UserSetupTableViewController.scrollDown(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view.addSubview(downArrow)
        }
        Mixpanel.mainInstance().identify(distinctId: "564")
        
        Mixpanel.mainInstance().track(event: "viewDidLoad",
                                      properties: ["Plan" : "Free"])
        
        
        
        
    }
    
    func scrollDown(sender: UIButton!) {
        //self.tableView.contentOffset.y = self.view.frame.size.height
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 2)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        print("here")
        
        if let viewWithTag = self.view.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
        }else{
            print("tag not found")
        }
        self.view.willRemoveSubview(downArrow)
        
        upArrow = UIButton(frame: CGRect(x: self.view.frame.size.width - 50, y: 150, width: 50, height: 50))
        upArrow.tag = 2
        
        upArrow.setImage(UIImage(named: "up"), forState: .Normal)
        upArrow.addTarget(self, action: #selector(UserSetupTableViewController.scrollUp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(upArrow)
        
        
    }
    func scrollUp(sender: UIButton!) {
        //self.tableView.contentOffset.y = self.view.frame.size.height
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        print("here")
        if let viewWithTag = self.view.viewWithTag(2) {
            viewWithTag.removeFromSuperview()
        }else {
            print("tag not found")
        }
        
        
        downArrow = UIButton(frame: CGRect(x: self.view.frame.size.width - 50, y: self.view.frame.size.height - 100, width: 50, height: 50))
        downArrow.tag = 1
        downArrow.setImage(UIImage(named: "down"), forState: .Normal)
        downArrow.addTarget(self, action: #selector(UserSetupTableViewController.scrollDown(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(downArrow)
        
        
        
    }

   
    
    
    
    
    @IBAction func finishButton(sender: AnyObject) {
        
        if isSectionLeader.on == true && isAdmin.on == true {
            displayAlert("Both Selected", message: "Please select either \"Drum Major\" or \"Section Leader\"")
        } else {
            user!.setObject(isSectionLeader.on, forKey: "isSectionLeader")
            
            user!.setObject(isAdmin.on, forKey: "isAdmin")
            user!.saveInBackground()
            
            if user!["marchingInstrument"] != nil && user!["concertInstrument"] != nil && user!["concertBandType"] != nil{
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
                UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
                mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController")
            } else {
                displayAlert("Missing Fields", message: "Please select: \nA marching band instrument\n A concert band instrument\nYour concert band")
            }
        }
        
        
        
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    
}
