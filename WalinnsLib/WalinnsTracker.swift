
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
import CoreFoundation
import NotificationCenter


public class WalinnsTracker : NSObject{
   
    //sharedInstance
    static let sharedInstance = WalinnsTracker()
 
    public var start_time = Utils.init().getCurrentUtc()
    public var end_time = "na"
    public var pushToken = "na"
    public var profile : NSMutableDictionary? = nil
    public var exception_ : String = "na"
   
    public static func initialize(project_token : String)  {
        Utils.init().save_pref(key: "token", value:project_token)
        
                NSSetUncaughtExceptionHandler { exception in
                    print("EXCEPTION CAUGHT HERE....")
                    print("WalinnsTrackerClient error" , exception)
                    print("WalinnsTrackerClient reason",exception.callStackSymbols)
                   // CrashStatus(crash_reason: String(describing: exception))
                }
        
        
        sharedInstance.start()
        print("WlinnsTrackerClient" + project_token , self)
        NotificationCenter.default.addObserver(WalinnsTracker.sharedInstance, selector: #selector(sharedInstance.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        WalinnsTrackerClient.init(token: project_token)
        
     }
    
     @objc func appMovedToBackground(){
            DispatchQueue.global(qos: .background).async {

                DispatchQueue.main.async {
                    self.end_time = Utils.init().getCurrentUtc()
                    print("WalinnsTrackerClient end time!" , self.end_time )
                    if(Utils.init().read_pref(key: "token") != nil ){
                        WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).sessionTrack(start_timee : self.start_time ,end_time: self.end_time)
                        WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).appUserStatus(app_status: "no")
                        WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).appUninstallCount(pushToken: self.pushToken)
                    }
                }
            }
    }
       
   
    func start()  {
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            DispatchQueue.main.async {
                print("WalinnsTrackerClient start time" , WalinnsTracker.sharedInstance.profile)
                 let dummy : NSMutableDictionary = NSMutableDictionary()
                 if(Utils.init().read_pref(key: "token") != nil ){
                    if(WalinnsTracker.sharedInstance.profile != nil ){
                        WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).DeviceReq(jsonobject: WalinnsTracker.sharedInstance.profile!)
                    }else{
                        WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).DeviceReq(jsonobject: dummy)
                    }
                }
                
            }
        }
        

    }
    public static func eventTrack(event_typ : String,event_nam : String){
        print("event_data_token:" , Utils.init().read_pref(key: "token"))
       if (Utils.init().read_pref(key: "device_status") != nil){
          WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).eventTrack(event_type : event_typ ,event_name: event_nam )
        }
        
    }
    
    public static func ScreenTrack(screenName : String){
        
        if (Utils.init().read_pref(key: "device_status") != nil){
            WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).screenTrack(screen_name : screenName)
        }
        
    }
    public static func sendPushToken(push_token : String){
        if(push_token != nil){
            print("send push token :" , push_token , ".......", Utils.init().read_pref(key: "token"))
            WalinnsTracker.sharedInstance.pushToken = push_token
        }
    }
    public static func sendProfile(user_profile : NSDictionary){
        print("Json object for userprofile ", user_profile)
        WalinnsTracker.sharedInstance.profile = user_profile as! NSMutableDictionary
       
    }
    
    public static func CrashStatus(crash_reason : String){
        
        WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).crashStatus(crash_reason: crash_reason)
    }
    
}



