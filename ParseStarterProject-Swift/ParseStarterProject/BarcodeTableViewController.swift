//
//  BarcodeViewController.swift
//  Band App
//
//  Created by Zoe Sheill on 7/5/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import Parse

    


class BarcodeTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
    let cellIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 15, width: 200, height: 160)
        
        
        //Setting barcode image and locker image if it exists for user
        if let imageFile = user!["barcode"] as? PFFile {
            
            imageFile.getDataInBackgroundWithBlock({ (data, error) in
                if let downloadedImage = UIImage(data: data!) {
                    self.barcodeImage.image = downloadedImage
                }
                print("inside block")
            })
            
        }
        
        if let userLockerNumber = user!["lockerNumber"] as? String {
            
            myLockerNumber.text = userLockerNumber
            if let userLockerCombo = user!["lockerCombo"] as? String{
                myLockerCombo.text = userLockerCombo
            }
       
            setLockerInfo()
            
            if let hiddenRow = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1)) {
                print("hidden")
                hiddenRow.hidden = true
            }
        }
        
        createPicker()
        
        /*if barcodeImage.image != nil {
         barcodeImage.image = UIImage(named: "placeholder4")
         }
         if lockerImage.image != nil {
         lockerImage.image = UIImage(named: "placeholder4")
         }*/
        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BarcodeTableViewController.handleTap(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    
    
    
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        closePicker()
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
            displayAlert( "Software Update Needed", message: "Please update to iOS8 or later or contact an admin")
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
        
        
        
        if lockerComboField!.text != nil && lockerNumberField!.text != nil {
            
            myLockerCombo.text = lockerComboField.text!
            myLockerNumber.text = lockerNumberField.text!
            
            setLockerInfo()
            
            
            user!["lockerNumber"] = lockerNumberField.text!
            user!["lockerCombo"] = lockerComboField.text!
            
           
          user!.saveInBackground()
            
            displayAlert("Success!", message: "You can always change your locker info in Settings")
            
        } else {
            displayAlert("Field(s) Empty", message: "Please enter your locker number and combination")
        
        }
        
        
    }
    
    func setLockerInfo() {
        
        //Changing view to remove cells and "choose image" buttons
        if lockerComboField!.text != nil {
            
            
            
            lockerComboField.removeFromSuperview()
            lockerNumberField.removeFromSuperview()
            /*if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
            }else{
                print("tag not found")
            }
            if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
            }else{
                print("tag not found")
            }*/

            myLockerCombo.center = CGPointMake(self.view.center.x, lockerCell.frame.size.height / 2)
       
            myLockerCombo.textAlignment = NSTextAlignment.Center

            myLockerNumber.center = CGPointMake(self.view.center.x, lockerCell.frame.size.height / 2)
            
            
            myLockerNumber.textAlignment = NSTextAlignment.Center
            
            if let hiddenRow = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1)) {
                hiddenRow.hidden = true
            }
            
            
            
            
            
        }
    }

 
    @IBOutlet weak var barcodeButton: UIButton!

 
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 1 && indexPath.section == 0{
            if user!["lockerNumber"] != nil {
                return 0.0
            }
        }
        
        if indexPath.row == 2 && indexPath.section == 1 {
            if user!["lockerCombo"] != nil {
                return 0.0
            }
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
  
        
        
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        if picker == pickedBarcodeImage {
            if let imageFile = PFFile(name: "image.png", data: imageData!) {
                
                user!.saveInBackgroundWithBlock({ (success, error) in
                    if success {
                        print("success")
                    } else {
                        print(error)
                    }
                    
                })
                user!["barcode"] = imageFile
                user!.saveInBackground()
                //user!.saveEventually()
                print("setImage")
            
            self.barcodeImage.image = image
                
              self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.hidden = true
                displayAlert("Success!", message: "You can always change this image in settings")
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
        
        for (index, event) in properties.memberPickerEvents.enumerate()
        {
            let button = UIButton()
            
            button.frame = CGRect(x: 0, y: offset, width: 200, height: 40)
            button.setTitleColor(event["color"] as? UIColor, forState: .Normal)
            button.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
            button.setTitle(event["title"] as? String, forState: .Normal)
            button.tag = index
            
            button.userInteractionEnabled = true
            
            button.addTarget(self, action: #selector(BarcodeTableViewController.pickerButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
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
            self.performSegueWithIdentifier("goToAboutUs", sender: self)
        } else if sender.tag == 2 {
            
            /*let subject = "Contact Us"
            let body = " "
            
            let email = "mailto:parker.bixby@mercerislandschools.org?subject=\(subject)&body=\(body)".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())

            if let emailURL:NSURL = NSURL(string: email!)
            {
                if UIApplication.sharedApplication().canOpenURL(emailURL)
                {
                    UIApplication.sharedApplication().openURL(emailURL)
                }
            }*/
            self.performSegueWithIdentifier("toEmailVC", sender: self)
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closePicker()
        
        self.view.endEditing(true)
        
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
