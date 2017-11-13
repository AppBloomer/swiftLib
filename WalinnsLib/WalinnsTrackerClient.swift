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
       
        print("WalinnsTrackerClient init", project_token , ",,,,", DeviceData.init().device_model())
        
        
        
        DeviceReq()
    
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
        
        
        //print("JSON OBJEC" , jsonObject)
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            ApiClient().varsharedInstance(suburl: "devices" ,json : jsonString);
        } catch _ {
            print ("JSON Failure")
        }
    }
    
}



 

 
