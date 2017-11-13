
///
///  WalinnsTracker.swift
///  WalinnsLib
///
///  Created by WALINNS INNOVATION on 01/11/17.
///  Copyright © 2017 WALINNS INNOVATION. All rights reserved.
///

import Foundation
import UIKit

public class WalinnsTracker: NSObject {

    //sharedInstance
    static let sharedInstance = WalinnsTracker()
    
     public static func initialize(project_token : String)  {
        print("WlinnsTrackerClient" + project_token)
        WalinnsTrackerClient.init(token: project_token)
        
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
        WalinnsTrackerClient.init().eventTrack(event_type : event_typ ,event_name: event_nam )
    }
}


