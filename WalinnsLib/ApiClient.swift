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
    
    struct singleton {
        static let sharedInstance = ApiClient()
    }
    func varsharedInstance(suburl : String ,json : String) -> NSObject {
           print("Passed value :" , suburl , json)
          postRequest(api: suburl , jsonString: json)
          return (singleton.sharedInstance)
    }
    
    
    var url_base = "http://192.168.0.11:8083/"
    func postRequest (api: String,jsonString : String, parameters: [String: Any]? = nil) {
        print("Passed value_inside_loop:", api , url_base )
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
                        print("Http_response_","Http_response_","1234")
                        if(api == "devices"){
                            print("DEVice_api-sucess" , api)
                        Utils.init().save_pref(key: "token" , value: "qwertyuiop123")
                        }
                    } else {
                        print("Http_response_","ABCD")
                    }
                } catch {
                    print(error)
                }
            } else {
                print(error ?? "")
            }
        }
        task.resume()
        print(url_base + api)
    }
    
    
   


}


