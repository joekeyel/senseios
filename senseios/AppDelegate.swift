//
//  AppDelegate.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 27/09/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID

import IQKeyboardManagerSwift
import UserNotifications
import GoogleMaps
import GooglePlaces

import AudioToolbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        GMSServices.provideAPIKey("AIzaSyAS4IpUQrUciALx0JTUZFx0f1UpsAIxfeA")
        GMSPlacesClient.provideAPIKey("AIzaSyAS4IpUQrUciALx0JTUZFx0f1UpsAIxfeA")
        
        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        
        
//        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate

        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
            if (granted) {
                UIApplication.shared.registerForRemoteNotifications()
            } else{
                print("Notification permissions not granted")
            }
        })
        
      
        
        let notificationOption = launchOptions?[.remoteNotification]
        
        if (notificationOption as? [String: AnyObject]) != nil{
            
            
            (window?.rootViewController as? startpagecontroller)?.pushnotification = true
            
        }
        
      
        
        return true
    }
    
    private func application(_ application: UIApplication, didRegister notificationSettings: UNNotification) {
        
        
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                
                
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //Handle the notification
        //This will get the text sent in your notification
        let body = notification.request.content.body
        
        //This works for iphone 7 and above using haptic feedback
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
        
        //This works for all devices. Choose one or the other.
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), nil)
        
        completionHandler( [.alert,.sound])
    }
    
    //when user tap the notification on foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
     
            //if user not login to firebase will go to the start page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //                let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "startpage") as! startcontroller
        
        
         if Auth.auth().currentUser != nil {
            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "reveal") as! SWRevealViewController
        
            
            if let window = self.window, let rootViewController = window.rootViewController {
                var currentController = rootViewController
                while let presentedController = currentController.presentedViewController {
                    currentController = presentedController
                }
                currentController.present(initialViewController2, animated: true, completion: nil)
            }
            
         }else{
            
            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "login") as! LoginController
            
            
            if let window = self.window, let rootViewController = window.rootViewController {
                var currentController = rootViewController
                while let presentedController = currentController.presentedViewController {
                    currentController = presentedController
                }
                currentController.present(initialViewController2, animated: true, completion: nil)
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

