//
//  AppDelegate.swift
//
//  Created by Muhammad Fatani on 21/12/2017.
//  Copyright © 2017 Muhammad Fatani. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseDatabase
import UserNotifications
import FirebaseCore
import FirebaseInstanceID
import FirebaseMessaging


/// Hold the firebase token to use it later
var MY_TOKEN:String? = nil


/// Flag to determine if the user in the chat view or not, if the user in chat view do not show the notification, otherwise show
var IS_IN_CHAT_WINDOW: Bool = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate{

    var window: UIWindow?


    
    @nonobjc func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    /// Connect to the firebsse and generate the token
    func ConnectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true
        if let token = InstanceID.instanceID().token() {
            MY_TOKEN = token
            print("DCS: " + token)
        }
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("fcm token: ", fcmToken)
        ConnectToFCM()
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("messaging: " , messaging)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //Every time notification come count that
        UIApplication.shared.applicationIconBadgeNumber += 1
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.confrontstar.Erslni-Delegators"), object: nil)
        
        
        if !IS_IN_CHAT_WINDOW {
            completionHandler([.alert, .badge, .sound])
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [String : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        //Parse the notification message data
        if let values = userInfo["values"] {
            
            
            //Navigate to the chat window
            // if !IS_IN_CHAT_WINDOW{
                
//                let styBoard = UIStoryboard(name: "Main", bundle: nil)
//                let uiNV = styBoard.instantiateViewController(withIdentifier: "NVChat") as! UINavigationController
//                let destinationViewController = uiNV.topViewController as! UR_CALSS
//                destinationViewController.senderDisplayName = delegatorName
//                destinationViewController.delegatorFCMToken = delegatorFCMToken
//                destinationViewController.channelRef = self.channelRef.child(channelId)
//                destinationViewController.isFromNotificationType = true
//                self.window?.rootViewController =  uiNV
//                self.window?.makeKeyAndVisible()
            // }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Active the notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
            if err != nil {
                //Something bad happend
            } else {
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self

                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        FirebaseApp.configure()
        //Google service register the key
        GMSServices.provideAPIKey("KEY")
        GMSPlacesClient.provideAPIKey("KEY")
                
        if let _ = IS_USER_LOGIN{
            self.window!.rootViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "NaviController") as! UINavigationController
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     
        Messaging.messaging().shouldEstablishDirectChannel = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        self.ConnectToFCM()
        
        //When the user enter the app reset the icon badge to the zero
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

