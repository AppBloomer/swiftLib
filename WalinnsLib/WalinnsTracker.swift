
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
  
   
    public static func initialize(project_token : String, viewController : UIViewController)  {
        Utils.init().save_pref(key: "token", value:project_token)
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
                print("WalinnsTrackerClient start time" , self.start_time)
                WalinnsTrackerClient.init(token: Utils.init().read_pref(key: "token")).DeviceReq()
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
    }
    
}



