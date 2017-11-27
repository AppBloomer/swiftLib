
///
///  WalinnsTracker.swift
///  WalinnsLib
///
///  Created by WALINNS INNOVATION on 01/11/17.
///  Copyright © 2017 WALINNS INNOVATION. All rights reserved.
///

import Foundation
import UIKit
import CoreData

import FirebaseMessaging
import UserNotifications
import Firebase

public class WalinnsTracker {

    //sharedInstance
    static let sharedInstance = WalinnsTracker()
    public static var flag : String = "na"
    public static var flag_1 : String = "na"
    
     public static func initialize(project_token : String)  {
        print("WlinnsTrackerClient" + project_token)
        WalinnsTrackerClient.init(token: project_token).start()
        WalinnsDelegate.init()
     }
    
    func start(project_token : String)  {
        print(project_token)
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                switch UIApplication.shared.applicationState {
                case .active:
                    print("Device status :" , "active")
                case .background:
                    
                    print("Device status :" , "bg")
                    print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
                case .inactive:
                    break
                }
            }
        }
        

    }
    public static func eventTrack(event_typ : String,event_nam : String){
        print("event_data_token:" , Utils.init().read_pref(key: "token"))
        if(Utils.init().read_pref(key: "token") != nil){
          WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).eventTrack(event_type : event_typ ,event_name: event_nam )
        }
        
    }
    
    public static func ScreenTrack(screenName : String){
        
        if(Utils.init().read_pref(key: "token") != nil){
            WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).screenTrack(screen_name : screenName)
        }
        
    }
    public static func sendPushToken(push_token : String){
        if(push_token != nil){
            print("send push token :" , push_token , ".......", Utils.init().read_pref(key: "token"))
            if(Utils.init().read_pref(key: "token") != nil){
                WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).appUninstallCount(pushToken: push_token)
            }
        }
    }
   
    public class WalinnsDelegate : UIResponder,UIApplicationDelegate , UNUserNotificationCenterDelegate , MessagingDelegate{
        public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            FirebaseApp.configure()
            print("WalinnsTrackerClient firebase" , "walinnsdelegate start")
            if #available(iOS 10.0, *) {
                let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_,_ in })
                
                // For iOS 10 display notification (sent via APNS)
                UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate
                // For iOS 10 data message (sent via FCM)
                Messaging.messaging().remoteMessageDelegate = self as! MessagingDelegate
                
            }
            application.registerForRemoteNotifications()
            return true
        }
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            let userInfo = notification.request.content.userInfo
            // Print message ID.
            print("Message ID: \(userInfo["gcm.message_id"]!)")
            
            // Print full message.
            print("%@", userInfo)
            
        }
        
        func application(received remoteMessage: MessagingRemoteMessage) {
            print("%@", remoteMessage.appData)
        }
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
            print("WalinnsTrackerClient FCM token ", fcmToken)
            WalinnsTracker.sendPushToken(push_token: fcmToken)
            
            UserDefaults.standard.set(fcmToken, forKey: "fcm_token")
        }
    }
    
}



