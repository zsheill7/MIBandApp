//
//  LoginViewController.swift
//  Band App
//
//  Created by Zoe Sheill on 7/5/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import Parse

extension String {
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(self)
    }
}

class SignupViewController: UIViewController, UITextFieldDelegate {
    var signupActive = true
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
  
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!


     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                               
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            print("error")
        }
       
        
        
    }
    @IBAction func logIn(sender: AnyObject) {
        let loginNC = storyboard?.instantiateViewControllerWithIdentifier("loginNC")
        loginNC!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(loginNC!, animated: true, completion: nil)
    }

    @IBAction func signUp(sender: AnyObject) {
   
        
        if password.text == "" || confirmPassword.text == "" || firstName.text == "" || lastName.text == "" || email.text == ""{
            
            displayAlert("Error", message: "Please complete all sections")
            
        } else if email.text?.isEmail() == false{
            displayAlert("Error", message: "\"\(email.text!)\" is not a valid email address")
            
        }else if password.text!.characters.count < 5 {
            self.displayAlert("Not Long Enough", message: "Please enter a password that is 5 or more characters")
        } else if password.text != confirmPassword.text {
            self.displayAlert("Passwords Do Not Match", message: "Please re-enter passwords")
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Please try again later"
            
            if signupActive == true {
                
                var user = PFUser()
                
                user.password = password.text!
                user.username = email.text!
                user["firstName"] = firstName.text!
                user["lastName"] = lastName.text!
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        // Signup successful
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            [unowned self] in
                            self.performSegueWithIdentifier("toAdminStatus", sender: self)
                        }
                        
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                        }
                        
                        self.displayAlert("Failed SignUp", message: errorMessage)
                        
                    }
                    
                })
                
            } else {
                
                
            }
            
        }
    }
    
        
    @IBAction func homeButtonPressed(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainStoryboard.instantiateViewControllerWithIdentifier("initialVC")
        self.presentViewController(initialVC, animated: true, completion: nil)
    }
  
    override func viewDidAppear(animated: Bool) {
        /*if PFUser.currentUser() != nil {
            
            self.performSegueWithIdentifier("signup", sender: self)
            
            
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        password.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        confirmPassword.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
  /*override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            
            self.performSegueWithIdentifier("login", sender: self)
            
            
        }
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
