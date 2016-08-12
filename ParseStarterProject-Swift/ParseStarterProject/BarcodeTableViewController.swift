//
//  BarcodeViewController.swift
//  Band App
//
//  Created by Zoe Sheill on 7/5/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import Parse

class BarcodeTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate {
    
    //User locker info
    @IBOutlet weak var myLockerCombo: UILabel!

    @IBOutlet weak var myLockerNumber: UILabel!
 
    
    @IBOutlet weak var lockerCell: UITableViewCell!
    @IBOutlet weak var lockerComboField: UITextField!
    
    @IBOutlet weak var lockerNumberField: UITextField!
    
    //User barcode info

   @IBOutlet weak var barcodeImage: UIImageView!

    
    var activityIndicator = UIActivityIndicatorView()
    let pickedBarcodeImage = UIImagePickerController()
    
    let pickedLockerImage = UIImagePickerController()
    
    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    var pickerFrame: CGRect?
    
    var user = PFUser.currentUser()
    
    
    
    struct properties {
        static let pickerEvents = [
            ["title" : "Settings", "color" : UIColor(red:0.19, green:0.54, blue:0.98, alpha:1.0)],
            ["title" : "About Us", "color": UIColor(red:0.19, green:0.54, blue:0.98, alpha:1.0)],
            ["title" : "Suggest a Change", "color" : UIColor(red:0.19, green:0.54, blue:0.98, alpha:1.0)],

        ]
    }
    
    

    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.modalPresentationStyle = .Popover
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            print("error")
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 10, width: 200, height: 160)
        //Setting barcode image and locker image if it exists for user
        if let userBarcodeImage = user!.objectForKey("barcode") {
            barcodeImage.image = userBarcodeImage as? UIImage
            print("@barcode")
        }
        
        if let userLockerNumber = user!.objectForKey("lockerNumber") {
            
            myLockerNumber.text = userLockerNumber as? String
            if let userLockerCombo = user!.objectForKey("lockerCombo") {
                myLockerCombo.text = userLockerCombo as? String
            }
            print("@locker")
            setLockerInfo()
        }
        
        createPicker()
        
        /*if barcodeImage.image != nil {
         barcodeImage.image = UIImage(named: "placeholder4")
         }
         if lockerImage.image != nil {
         lockerImage.image = UIImage(named: "placeholder4")
         }*/
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    
    @IBAction func takePhoto(sender: AnyObject) {
        //UIAlertController for choosing photo

        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .ActionSheet)
            let choosePhoto = UIAlertAction(title: "Choose from Photo Library", style: .Default) { (_) in
                self.pickedBarcodeImage.delegate = self
                self.pickedBarcodeImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.pickedBarcodeImage.allowsEditing = false
                
                self.presentViewController(self.pickedBarcodeImage, animated: true, completion: nil)
                
                //barcodeImage.image = image
                
            }
        
            

            let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { (_) in
                self.pickedBarcodeImage.delegate = self
                self.pickedBarcodeImage.sourceType = UIImagePickerControllerSourceType.Camera
                self.pickedBarcodeImage.allowsEditing = false
                
                self.presentViewController(self.pickedBarcodeImage, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
            
            alertController.addAction(choosePhoto)
            alertController.addAction(takePhoto)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            displayAlert( "Software Update Needed", message: "Please update to iOS8 or later or hggg contact an admin")
        }
        
        
    }
 
    @IBAction func chooseLockerPhoto(sender: AnyObject) {
        /*if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .Alert)
            let choosePhoto = UIAlertAction(title: "Choose from Photo Library", style: .Default) { (_) in
                self.pickedLockerImage.delegate = self
                self.pickedLockerImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.pickedLockerImage.allowsEditing = false
                
                self.presentViewController(self.pickedLockerImage, animated: true, completion: nil)
                
                //barcodeImage.image = image
                
            }
            let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { (_) in
                self.pickedLockerImage.delegate = self
                self.pickedLockerImage.sourceType = UIImagePickerControllerSourceType.Camera
                self.pickedLockerImage.allowsEditing = false
                
                self.presentViewController(self.pickedLockerImage, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
            
            alertController.addAction(choosePhoto)
            alertController.addAction(takePhoto)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            displayAlert( "Software Update Needed", message: "Please update to iOS8 or later or contact an admin")
        }*/
        
        
        
        if lockerComboField?.text != nil {
            
            myLockerCombo.text = lockerComboField.text!
            myLockerNumber.text = lockerNumberField.text!
            
            setLockerInfo()
            
            
            user!.setObject(lockerNumberField.text!, forKey: "lockerNumber")
            user!.setObject(lockerComboField.text!, forKey: "lockerCombo")

            displayAlert("Success!", message: "You can always change your locker info in Settings")
            
        } else {
            displayAlert("Field(s) Empty", message: "Please enter your locker number and combination")
        
        }
        
        
    }
    
    func setLockerInfo() {
        
        //Changing view to remove cells and "choose image" buttons
        if lockerComboField?.text != nil {
            
            lockerComboField?.tag = 1
            lockerNumberField?.tag = 1
            if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
            }else{
                print("tag not found")
            }
            if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
            }else{
                print("tag not found")
            }

            myLockerCombo.center = CGPointMake(self.view.center.x, lockerCell.frame.size.height / 2)
       
            myLockerCombo.textAlignment = NSTextAlignment.Center

            myLockerNumber.center = CGPointMake(self.view.center.x, lockerCell.frame.size.height / 2)
            
            
            myLockerNumber.textAlignment = NSTextAlignment.Center
            
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1))!.hidden = true
            
            user!.setObject(lockerNumberField.text!, forKey: "lockerNumber")
            user!.setObject(lockerComboField.text!, forKey: "lockerCombo")
            
            
        }
    }

 
    @IBOutlet weak var barcodeButton: UIButton!

 
    

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
  
        
        
        let imageData = UIImagePNGRepresentation(image)
        if picker == pickedBarcodeImage {
            if let imageFile = PFFile(name: "image.png", data: imageData!) {
                user!.setObject(imageFile, forKey: "barcode")
                
            imageFile.getDataInBackgroundWithBlock({ (data, error) in
                if let downloadedImage = UIImage(data: data!) {
                    self.barcodeImage.image = downloadedImage
                }
            })
              self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.hidden = true
                displayAlert("Sucess!", message: "You can always change this image in settings")
            }
        } /*else if picker == pickedLockerImage {
            if let imageFile = PFFile(name: "image.png", data: imageData!) {
                
                user!.setObject(imageFile, forKey: "locker")
                
                imageFile.getDataInBackgroundWithBlock({ (data, error) in
                    if let downloadedImage = UIImage(data: data!) {
                        self.lockerImage.image = downloadedImage
                    }
                })
            }
                
        }*/
        
        
        
        //takePhotoButtonLabel.setTitle("", forState: UIControlState.Normal)
        //choosePhotoButtonLabel.setTitle("", forState: UIControlState.Normal)
    }
    
    //Creates dropdown menu bar that includes "Settings," "About Us," "Suggested Changes"
    
    @IBAction func pickerSelect(sender: UIBarButtonItem) {
        picker.hidden ? openPicker() : closePicker()
    }
    
    func createPicker()
    {
        picker.frame = self.pickerFrame!
        picker.alpha = 0
        picker.hidden = true
        picker.userInteractionEnabled = true
        
        var offset = 18
        
        for (index, event) in properties.pickerEvents.enumerate()
        {
            let button = UIButton()
            
            button.frame = CGRect(x: 0, y: offset, width: 200, height: 44)
            button.setTitleColor(event["color"] as? UIColor, forState: .Normal)
            button.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
            button.setTitle(event["title"] as? String, forState: .Normal)
            button.tag = index

            button.userInteractionEnabled = true
            
            button.addTarget(self, action: #selector(BarcodeTableViewController.pickerButtonTapped(_:)), forControlEvents: UIControlEvents.TouchDown)
            
            picker.addSubview(button)
            
            offset += 44
        }
        
        view.addSubview(picker)
    
    }
    
    func openPicker()
    {
        self.picker.hidden = false
        
        UIView.animateWithDuration(0.3) { 
            self.picker.frame = self.pickerFrame!
            self.picker.alpha = 1
        }
    }
    
    func closePicker()
    {
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.picker.frame = self.pickerFrame!
                                    self.picker.alpha = 0
            },
                                   completion: { finished in
                                    self.picker.hidden = true
            }
        )
    }

    func pickerButtonTapped(sender: UIButton!) {
        
        closePicker()
        if sender.tag == 0 {
            print("here")
            /*let settingsVC = storyboard?.instantiateViewControllerWithIdentifier("settingsNC")
            self.presentViewController(settingsVC!, animated: true, completion: nil)*/
            self.performSegueWithIdentifier("goToSettings", sender: self)
        } else if sender.tag == 1 {
          
            
            /*let aboutUsVC = storyboard?.instantiateViewControllerWithIdentifier("aboutUsVC")
            self.presentViewController(aboutUsVC!, animated: true, completion: nil)*/
            self.performSegueWithIdentifier("goToSettings", sender: self)
        } else if sender.tag == 2 {
            
            let subject = "Suggested Changes/Bug fixes to MIHS Band App"
            let body = "Hello"
            
            let email = "mailto:zsheill7@gmail.com?subject=\(subject)&body=\(body)".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())

            if let emailURL:NSURL = NSURL(string: email!)
            {
                if UIApplication.sharedApplication().canOpenURL(emailURL)
                {
                    UIApplication.sharedApplication().openURL(emailURL)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
