//
//  WalinnsTrackerClient.swift
//  WalinnsLib
//
//  Created by WALINNS INNOVATION on 01/11/17.
//  Copyright © 2017 WALINNS INNOVATION. All rights reserved.
//

import Foundation
import UIKit


class WalinnsTrackerClient {
    
    var project_token : String
    var device_id = UIDevice.current.identifierForVendor!.uuidString
 
    var timer: Timer!
    var sessionStartTime: TimeInterval = Date().timeIntervalSince1970
    var sessionLength: TimeInterval = 0
    var sessionEndTime: TimeInterval = 0
    var start_time : String = Utils.init().getCurrentUtc()
    var end_time : String = ""
 
    
    init(token :String ) {
        self.project_token = token
        if(UserDefaults.standard.string(forKey: device_id) != nil){
         print("DEVICE ID second TIME: " , self.device_id , "old.." , UserDefaults.standard.string(forKey: device_id))
        }else{
         UserDefaults.standard.set(self.device_id, forKey: "device_id")
         UserDefaults.standard.synchronize()
         print("DEVICE ID FIRST TIME: " , self.device_id)
        }
        
    }
    
    func DeviceReq(jsonobject : NSDictionary) {
        let jsonObjectt : NSMutableDictionary = NSMutableDictionary()
        if(jsonobject != nil && jsonobject.value(forKey: "email") != nil){
              jsonObjectt.setValue(jsonobject.value(forKey: "gender"), forKey: "gender")
             jsonObjectt.setValue(jsonobject.value(forKey: "email"), forKey: "email")
             jsonObjectt.setValue(Utils.init().calcAge(birthday : jsonobject.value(forKey: "dob") as! String), forKey: "age")
            
        }else{
             jsonObjectt.setValue("Male", forKey: "gender")
             jsonObjectt.setValue(DeviceData.init().email(), forKey: "email")
             jsonObjectt.setValue(DeviceData.init().age(), forKey: "age")
        }
         
        
        jsonObjectt.setValue(device_id, forKey: "device_id")
        jsonObjectt.setValue(DeviceData.init().device_model(), forKey: "device_model")
        jsonObjectt.setValue(DeviceData.init().os_name(), forKey: "os_name")
        jsonObjectt.setValue(DeviceData.init().os_version(), forKey: "os_version")
        jsonObjectt.setValue(DeviceData.init().app_version(), forKey: "app_version")
        jsonObjectt.setValue(DeviceData.init().checkWiFi, forKey: "connectivity")
        jsonObjectt.setValue(DeviceData.init().carrierName(), forKey: "carrier")
        jsonObjectt.setValue("false", forKey: "play_service")
        jsonObjectt.setValue("false", forKey: "bluetooth")
        jsonObjectt.setValue(DeviceData.init().screendpi(), forKey: "screen_dpi")
        jsonObjectt.setValue(DeviceData.init().screenHeight(), forKey: "screen_height")
        jsonObjectt.setValue(DeviceData.init().screenWidth(), forKey: "screen_width")
        jsonObjectt.setValue(DeviceData.init().language(), forKey: "language")
        jsonObjectt.setValue(DeviceData.init().location(), forKey: "country")
        jsonObjectt.setValue(Utils.init().getCurrentUtc(),forKey: "date_time")
        print("WalinnsTrackerClient Device:", jsonObjectt )
        convertToJson(json_obj : jsonObjectt ,service_name : "devices" )
        
        
    }
    
    public func eventTrack(event_type : String, event_name : String) {
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(event_name, forKey: "event_name")
        jsonObject.setValue(event_type, forKey: "event_type")
        jsonObject.setValue(Utils.init().getCurrentUtc(), forKey: "date_time")
        print("WalinnsTrackerClient event:", jsonObject )
        convertToJson(json_obj : jsonObject ,service_name : "events" )

    }
    public func screenTrack(screen_name : String) {
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(screen_name, forKey: "screen_name")
        jsonObject.setValue(Utils.init().getCurrentUtc(), forKey: "date_time")
        print("WalinnsTrackerClient session:", jsonObject )
        convertToJson(json_obj : jsonObject ,service_name : "screenView" )
        
    }
    
    func convertToJson(json_obj : NSMutableDictionary , service_name : String) {
        //print("JSON OBJEC" , jsonObject)
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: json_obj, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            api_name(type_name: service_name , jsonstring:jsonString , flag: "na")
            
        } catch _ {
            print ("JSON Failure")
            
        }
    }
    func convertToJson(json_obj : NSMutableDictionary , service_name : String , flag_status : String) {
        //print("JSON OBJEC" , jsonObject)
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: json_obj, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            api_name(type_name: service_name , jsonstring:jsonString , flag: flag_status)
            
        } catch _ {
            print ("JSON Failure")
            
        }
    }
    
    func api_name(type_name : String , jsonstring : String , flag : String) {
        switch type_name {
        case "devices":
            ApiClient().varsharedInstance(suburl: "devices" ,json : jsonstring);
            break
        case "screenView":
            ApiClient().varsharedInstance(suburl: "screenView" ,json : jsonstring);
            break
        case "events":
            ApiClient().varsharedInstance(suburl: "events" ,json : jsonstring);
            break
        case "session":
            ApiClient().varsharedInstance(suburl: "session" ,json : jsonstring);
            break
        case "fetchAppUserDetail":
            print("Fetch app user details :" , jsonstring)
            if(flag == "fetch_no"){
                ApiClient().varsharedInstance(suburl: "fetchAppUserDetail" ,json : jsonstring , flag_status: flag);
            }else{
               ApiClient().varsharedInstance(suburl: "fetchAppUserDetail" ,json : jsonstring);
            }
            break
            
        case "uninstallcount":
            ApiClient().varsharedInstance(suburl: "uninstallcount" ,json : jsonstring, flag_status: flag);
            break
            
        default: break
            
        }

    }
   
    
   
    func roundOneDigit(num: TimeInterval) -> TimeInterval {
        return round(num * 10.0) / 10.0
    }
    public func sessionTrack(start_timee : String , end_time : String){
        if (Utils.init().read_pref(key: "device_status") != nil){
      let terminationDuration = Utils.init().UTCToLocal(date: end_time).timeIntervalSince(Utils.init().UTCToLocal(date: start_timee))

                let jsonObject : NSMutableDictionary = NSMutableDictionary()
                jsonObject.setValue(device_id, forKey: "device_id")
                jsonObject.setValue(Utils.init().stringFromTimeInterval(interval: terminationDuration), forKey: "session_length")
                jsonObject.setValue(start_timee, forKey: "start_time")
                jsonObject.setValue(end_time, forKey: "end_time")
                print("WalinnsTrackerClient session:", jsonObject )
                convertToJson(json_obj : jsonObject ,service_name : "session" )
        }

    }
    
    public func appUserStatus(app_status : String){
        
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(app_status, forKey: "active_status")
        jsonObject.setValue(Utils.init().getCurrentUtc(), forKey: "date_time")
        
        if(app_status == "yes"){
            convertToJson(json_obj : jsonObject ,service_name : "fetchAppUserDetail" )
        }else{
            if (Utils.init().read_pref(key: "device_status") != nil){
             convertToJson(json_obj : jsonObject ,service_name : "fetchAppUserDetail", flag_status : "fetch_no")
            }
        }
    }
    public func appUninstallCount(pushToken : String){
        let bundleIdentifier =  Bundle.main.bundleIdentifier
        print("Bundle identifier :" , bundleIdentifier)
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(bundleIdentifier, forKey: "package_name")
        jsonObject.setValue(pushToken, forKey: "push_token")
        jsonObject.setValue(Utils.init().getCurrentUtc(), forKey: "date_time")
        
        print("Bundle identifier object:" , jsonObject)
        convertToJson(json_obj : jsonObject ,service_name : "uninstallcount" )
    }
    
    func crashStatus(crash_reason : String) {
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(crash_reason, forKey: "reason")
        jsonObject.setValue(Utils.init().getCurrentUtc(), forKey: "date_time")
    }
    
    
}







