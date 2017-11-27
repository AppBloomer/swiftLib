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
    }
    
    func DeviceReq() {
         
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(DeviceData.init().device_model(), forKey: "device_model")
        jsonObject.setValue(DeviceData.init().os_name(), forKey: "os_name")
        jsonObject.setValue(DeviceData.init().os_version(), forKey: "os_version")
        jsonObject.setValue(DeviceData.init().app_version(), forKey: "app_version")
        jsonObject.setValue(DeviceData.init().Connectivy_gen(), forKey: "connectivity")
        jsonObject.setValue(DeviceData.init().carrierName(), forKey: "carrier")
        jsonObject.setValue("false", forKey: "play_service")
        jsonObject.setValue("false", forKey: "bluetooth")
        jsonObject.setValue(DeviceData.init().screendpi(), forKey: "screen_dpi")
        jsonObject.setValue(DeviceData.init().screenHeight(), forKey: "screen_height")
        jsonObject.setValue(DeviceData.init().screenWidth(), forKey: "screen_width")
        jsonObject.setValue(DeviceData.init().age(), forKey: "age")
        jsonObject.setValue("Male", forKey: "gender")
        jsonObject.setValue(DeviceData.init().language(), forKey: "language")
        jsonObject.setValue(DeviceData.init().location(), forKey: "country")
        jsonObject.setValue(DeviceData.init().email(), forKey: "email")
        jsonObject.setValue(Utils.init().getCurrentUtc(),forKey: "date_time")
        print("WalinnsTrackerClient Device:", jsonObject )
        convertToJson(json_obj : jsonObject ,service_name : "devices" )
        
        
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
    func start() {
      //  timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(handleMyFunction), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(handleMyFunction), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
       // print("Timer started Device ...start..." , "start")
       // guard timer == nil else { return }
       // timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(handleMyFunction), userInfo: nil, repeats: true)
    }
    func stop() {
        timer.invalidate()
        //print("Timer started Device ...stop..." , "stop")
       // guard timer != nil else { return }
       // timer?.invalidate()
        //timer = nil
    }
    
    
    @objc func handleMyFunction() {
        // Code here
         //print("Timer started client",Date())
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue" , WalinnsTracker.flag_1+"......")
            
            DispatchQueue.main.async {
                
                switch UIApplication.shared.applicationState {
                case .active:
                    print("Timer started","Device status :" , "active" , WalinnsTracker.flag_1)
                    if(WalinnsTracker.flag_1 == "na"){
                        self.DeviceReq()
                    }else if(WalinnsTracker.flag_1 == "active_status"){
                        self.appUserStatus(app_status : "yes")
                    }else if(WalinnsTracker.flag_1 == "response_error"){
                        print("Timer started else if" , WalinnsTracker.flag_1)
                        self.stop()
                    }
                   
                case .background:
                    print("Timer started","Device status :" , "bg", WalinnsTracker.flag)
                    if(WalinnsTracker.flag == "na"){
                       self.sessionEndTime = Date().timeIntervalSince1970
                       self.end_time = Utils.init().getCurrentUtc()
                       self.sessionLength = self.roundOneDigit(num: self.sessionEndTime - self.sessionStartTime)
                       print("Timer started session length",self.sessionLength ,"start_time: ",self.sessionStartTime)
                      self.sessionTrack(start_timee :self.start_time,end_time :self.end_time,session_lenth:self.sessionLength)
                       
                    }else if(WalinnsTracker.flag == "session"){
                        self.appUserStatus(app_status : "no")
                    }
                    
                    if(WalinnsTracker.flag == "timer_end" ){
                    if(Utils.init().read_pref(key: "session") != nil && Utils.init().read_pref(key: "session") == "end" ){
                        print("Timer started","Device status stop :" , "bg", Utils.init().read_pref(key: "session"))
                         self.stop()
                    }
                    }
                   
                    
                case .inactive:
                     print("Timer started","Device status :" , "inactive", WalinnsTracker.flag)
                     
                    break
                }
            }
        }

    }
   
    func roundOneDigit(num: TimeInterval) -> TimeInterval {
        return round(num * 10.0) / 10.0
    }
    public func sessionTrack(start_timee : String , end_time : String , session_lenth : Double){
        
        print("Timer started Device",WalinnsTracker.flag,"Session track data :" , start_timee , end_time, session_lenth)
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(String(format:"%f", session_lenth), forKey: "session_length")
        jsonObject.setValue(start_timee, forKey: "start_time")
        jsonObject.setValue(end_time, forKey: "end_time")
        print("WalinnsTrackerClient session:", jsonObject )
        convertToJson(json_obj : jsonObject ,service_name : "session" )
        
    }
    
    public func appUserStatus(app_status : String){
        
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(app_status, forKey: "active_status")
        jsonObject.setValue(Utils.init().getCurrentUtc(), forKey: "date_time")
        print("WalinnsTrackerClient App user status:", app_status )
        if(app_status == "yes"){
             print("WalinnsTrackerClient App user status if:", app_status )
             convertToJson(json_obj : jsonObject ,service_name : "fetchAppUserDetail" )
        }else{
            print("WalinnsTrackerClient App user status else:", app_status )
            convertToJson(json_obj : jsonObject ,service_name : "fetchAppUserDetail", flag_status : "fetch_no")
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
    
    
    
}







