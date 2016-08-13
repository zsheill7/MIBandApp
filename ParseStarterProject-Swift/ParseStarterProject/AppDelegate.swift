/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit

import Parse

import Fabric
import Crashlytics
import Mixpanel
import TwitterKit

// If you want to use any of the UI components, uncomment this line
// import ParseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Enable storing and querying data from Local Datastore.
        // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
        Parse.enableLocalDatastore()
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "mihsbandGRHUILAEHFRALIWH4738568"
            $0.clientKey = "FUHIDLSHfnjdlsh48937596575789"
            $0.server = "https://mihsband.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        
        Fabric.with([Crashlytics.self, Twitter.self])

        Mixpanel.initialize(token: "8479c656aae75569e1d20b19ae9b20e1")
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        
        let nonmemberStoryboard = UIStoryboard(name: "Nonmember", bundle: nil)
        
        let nonmemberTBC = nonmemberStoryboard.instantiateViewControllerWithIdentifier("nonmemberTBC") as! UITabBarController
        let navigationViewController = nonmemberTBC.viewControllers![3] as! UINavigationController
        let photosViewController = navigationViewController.topViewController as! PhotosViewController
        photosViewController.store = PhotoStore()

        
        
        
        
        
        
       /* let token = "acf8f6a1484ea0ea2ffb2c18713ff265"
        let mixpanel = Mixpanel.sharedInstanceWithToken(token)*/
        
        //UINavigationBar.appearance().barTintColor = UIColor.redColor()
        
        UINavigationBar.appearance().titleTextAttributes =
            [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        UIBarButtonItem.appearance().tintColor = UIColor.grayColor()
        let navBgImage:UIImage = UIImage(named: "maroonSolid")!
        UINavigationBar.appearance().setBackgroundImage(navBgImage, forBarMetrics:  .Default)

        /*parse-dashboard --appId mihsbandGRHUILAEHFRALIWH4738568 --masterKey FUHIDLSHfnjdlsh48937596575789 --serverURL "https://mihsband.herokuapp.com/parse" --appName MIHS Band
 */
        // ****************************************************************************
        // Uncomment and fill in with your Parse credentials:
        // Parse.setApplicationId("your_application_id", clientKey: "your_client_key")
        //
        // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
        // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
        // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
        // PFFacebookUtils.initializeFacebook()
        // ****************************************************************************

        PFUser.enableAutomaticUser()

        let defaultACL = PFACL();

        // If you would like all objects to be private by default, remove this line.
        defaultACL.publicReadAccess = true

        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)

        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.

            let preBackgroundPush = !application.respondsToSelector(Selector("backgroundRefreshStatus"))
            let oldPushHandlerOnly = !self.respondsToSelector(#selector(UIApplicationDelegate.application(_:didReceiveRemoteNotification:fetchCompletionHandler:)))
            var noPushPayload = false;
            if let options = launchOptions {
                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
            }
            if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        
                
        //let nonmemberStoryboard = UIStoryboard(name: "Nonmember", bundle: nil)
        

        //
        //  Swift 1.2
        //
        //        if application.respondsToSelector("registerUserNotificationSettings:") {
        //            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        //            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        //            application.registerUserNotificationSettings(settings)
        //            application.registerForRemoteNotifications()
        //        } else {
        //            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
        //            application.registerForRemoteNotificationTypes(types)
        //        }

        //
        //  Swift 2.0
        //
        //        if #available(iOS 8.0, *) {
        //            let types: UIUserNotificationType = [.Alert, .Badge, .Sound]
        //            let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        //            application.registerUserNotificationSettings(settings)
        //            application.registerForRemoteNotifications()
        //        } else {
        //            let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
        //            application.registerForRemoteNotificationTypes(types)
        //        }

        return true
    }

    //--------------------------------------
    // MARK: Push Notifications
    //--------------------------------------

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()

        let mixpanel = Mixpanel.initialize(token:"4e35256cfd95a9b236936bcf0104bb92")
        
        mixpanel.identify(distinctId: "564") //564 is the unique distinct id of user
        mixpanel.people.set(properties: ["name": "your name", "$email": "email@email.com", "Plan": "Free", "$region" : "Australia"])
        mixpanel.people.addPushDeviceToken(deviceToken)
            
        PFPush.subscribeToChannelInBackground("") { (succeeded: Bool, error: NSError?) in
            if succeeded {
                print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n");
            } else {
                print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n", error)
            }
        }
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
        }
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
        
        var alert1: String = ""
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                    //Do stuff
                }
            } else if let alert = aps["alert"] as? NSString {
                print(alert)
                alert1 = alert as String
            }
        }
        let alertController = UIAlertController(title: "Notification", message:
            alert1, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you want to use Push Notifications with Background App Refresh
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    //     if application.applicationState == UIApplicationState.Inactive {
    //         PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
    //     }
    // }

    //--------------------------------------
    // MARK: Facebook SDK Integration
    //--------------------------------------

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you are using Facebook
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    //     return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, session:PFFacebookUtils.session())
    // }
}
