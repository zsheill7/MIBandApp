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
    @IBOutlet weak var myLockerCombo: UILabel!

    @IBOutlet weak var myLockerNumber: UILabel!
 
    
    @IBOutlet weak var lockerCell: UITableViewCell!
    @IBOutlet weak var lockerComboField: UITextField!
    
    @IBOutlet weak var lockerNumberField: UITextField!

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

    
    var activityIndicator = UIActivityIndicatorView()
    let pickedBarcodeImage = UIImagePickerController()
    
    let pickedLockerImage = UIImagePickerController()
    var user = PFUser.currentUser()
    
    
  
    
    @IBOutlet weak var barcodeImage: UIImageView!

    
    
    @IBAction func takePhoto(sender: AnyObject) {
        

        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .Alert)
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
        
        if lockerComboField?.text != nil {
            myLockerCombo.text = lockerComboField.text!
            myLockerCombo.center = CGPointMake(self.view.center.x, lockerCell.frame.size.height / 2)
            
            
            myLockerCombo.textAlignment = NSTextAlignment.Center
            
            myLockerNumber.text = lockerNumberField.text!
            myLockerNumber.center = CGPointMake(self.view.center.x, lockerCell.frame.size.height / 2)
            
            
            myLockerNumber.textAlignment = NSTextAlignment.Center
            
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1))!.hidden = true
            
            displayAlert("Success!", message: "You can always change your locker info in Settings")
            
        } else {
            displayAlert("Field(s) Empty", message: "Please enter your locker number and combination")
        
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
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
