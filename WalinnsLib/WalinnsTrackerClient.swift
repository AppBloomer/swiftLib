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
    
    init(token :String) {
        self.project_token = token
        print("WalinnsTrackerClient init", project_token )
        
        
    }
    
    func getInstance(token: String){
        print("WalinnsTrackerClient", token)
    }
    
}



 

 
