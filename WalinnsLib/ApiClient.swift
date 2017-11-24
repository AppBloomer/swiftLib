//
//  ApiClient.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 13/11/17.
//
//

import Foundation
import UIKit


class ApiClient : NSObject{
    public var flagval : String = "na"
    struct singleton {
        static let sharedInstance = ApiClient()
        
    }
    func varsharedInstance(suburl : String ,json : String) -> NSObject {
            
          postRequest(api: suburl , jsonString: json)
          return (singleton.sharedInstance)
    }
    func varsharedInstance(suburl : String ,json : String , flag_status : String) -> NSObject {
        print("Flag Status response..."  ,  flag_status)
        flagval = flag_status
        postRequest(api: suburl , jsonString: json)
        return (singleton.sharedInstance)
    }
    
    var url_base = "http://192.168.0.05:8083/"
    func postRequest (api: String,jsonString : String, parameters: [String: Any]? = nil) {
        
        guard let destination = URL(string: url_base + api) else { return }
        var request = URLRequest(url: destination)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("qwertyuiop123", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonString.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    if (json["response"]) != nil {
                        Logger.e(messing: "Flag Status response :"+api+"   flag..: "+self.flagval)
                        if(self.flagval == "na"){
                            self.api_call(falg_status: api)
                        }else{
                            self.api_call(falg_status: self.flagval)
                        }
                    }
                    else {
                        print("Http_response_","ABCD")
                    }
                } catch {
                    print("Http_response_error",error)
                }
            } else {
                print("Http_response_error1",error ?? "")
            }
        }
        task.resume()
        print(url_base + api)
    }
    
    func api_call(falg_status : String) {
        switch falg_status {
        case "devices":
            WalinnsTracker.flag_1 = "active_status"
            print("Flag Status" , falg_status)
            Utils.init().save_pref(key: "token" , value: "qwertyuiop123")
            break
        case "screenView":
            
            break
        case "events":
            
            break
        case "session":
            print("Flag Status session" , falg_status)

             WalinnsTracker.flag = "session"
            break
        case "fetchAppUserDetail":
            print("Flag Status user" , falg_status)
            WalinnsTracker.flag_1 = "end"
            break
        case "fetch_no":
              WalinnsTracker.flag = "timer_end"
             print("Flag Status fetch_no" , falg_status)
             Utils.init().save_pref(key: "session" , value: "end")
            break
            
        default: break
            
        }
        
    }

   


}


