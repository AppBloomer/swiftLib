
///
///  WalinnsTracker.swift
///  WalinnsLib
///
///  Created by WALINNS INNOVATION on 01/11/17.
///  Copyright © 2017 WALINNS INNOVATION. All rights reserved.
///

import Foundation
import UIKit

class WalinnsTracker: NSObject {

    //sharedInstance
    static let sharedInstance = WalinnsTracker()
    
    func initialize(project_token : String)  {
        print("WlinnsTrackerClient" + project_token)
        WalinnsTrackerClient.init(token: project_token)
    }
}


