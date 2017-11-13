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
    
    
    init(token :String) {
        self.project_token = token
        DeviceReq()
    }
    init() {
        
    }
     
    
    func DeviceReq() {
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(DeviceData.init().device_model(), forKey: "device_model")
        jsonObject.setValue(DeviceData.init().os_name(), forKey: "os_name")
        jsonObject.setValue(DeviceData.init().os_version(), forKey: "os_version")
        jsonObject.setValue(DeviceData.init().app_version(), forKey: "app_version")
        jsonObject.setValue(DeviceData.init().Connectivy_gen(), forKey: "connectivity")
        jsonObject.setValue("no sim", forKey: "carrier")
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
        
        convertToJson(json_obj : jsonObject ,service_name : "devices" )
        
        
    }
    
    public func eventTrack(event_type : String, event_name : String) {
        let jsonObject : NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(device_id, forKey: "device_id")
        jsonObject.setValue(event_name, forKey: "event_name")
        jsonObject.setValue(event_type, forKey: "event_type")
        jsonObject.setValue(Utils.init().getCurrentUtc(), forKey: "date_time")
        
        convertToJson(json_obj : jsonObject ,service_name : "events" )

    }
    
    func convertToJson(json_obj : String , service_name : String) {
        //print("JSON OBJEC" , jsonObject)
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: json_obj, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            api_name(type_name: service_name , jsonstring:jsonString )
            
        } catch _ {
            print ("JSON Failure")
            
        }
    }
    
    func api_name(type_name : String , jsonstring : String) {
        switch type_name {
        case "devices":
            ApiClient().varsharedInstance(suburl: "devices" ,json : jsonstring);
            break
        case "fetchAppUserDetail":
           //  ApiClient().varsharedInstance(suburl: "devices" ,json : jsonstring);
            break
        case "events":
            ApiClient().varsharedInstance(suburl: "events" ,json : jsonstring);
            break
        }

    }
    
}






