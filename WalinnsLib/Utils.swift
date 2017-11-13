//
//  Utils.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 13/11/17.
//
//

import Foundation
import UIKit

class Utils {
    
    func getCurrentUtc() -> String {
        let currentDateTime = Date()
       // print("Current_date_time", currentDateTime)
        let dt = String(describing: currentDateTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let someDateTime = formatter.date(from: dt)
        // print("Current_date_time2", someDateTime)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
       // print("Current_date_time3", formatter.string(from: someDateTime!))
        return  formatter.string(from: someDateTime!)

        
    }
    
}
