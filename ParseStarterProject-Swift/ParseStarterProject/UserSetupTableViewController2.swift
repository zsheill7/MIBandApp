import UIKit
import Parse


class UserSetupTableViewController2: UITableViewController {
    
    var user = PFUser.currentUser()
    
    @IBOutlet weak var isAdmin: UISwitch!
    
    @IBOutlet weak var isSectionLeader: UISwitch!
    
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            print("error")
        }
        
        
        
    }
    
    
   
    
    
    
    
    @IBAction func finishButton(sender: AnyObject) {
        user!.setObject(isSectionLeader.on, forKey: "isSectionLeader")
        user!.saveInBackground()
        user!.setObject(isAdmin.on, forKey: "isAdmin")
        user!.saveInBackground()
        
        if user!["marchingInstrument"] != nil && user!["concertInstrument"] != nil && user!["concertBandType"] != nil{
            self.performSegueWithIdentifier("finishSetup", sender: self)
        } else {
            displayAlert("Missing Fields", message: "Please select: \nA marching band instrument\n A concert band instrument\nYour concert band")
        }
    }
    
    
    
}
