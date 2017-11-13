//
//  Utils.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 13/11/17.
//
//

import Foundation

class Utils {
    
    func get_Date_time_from_UTC_time(string : String) -> String {
        
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateformattor.timeZone = NSTimeZone.local
        let dt = string
        let dt1 = dateformattor.date(from: dt as String)
        dateformattor.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        dateformattor.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
        return dateformattor.string(from: dt1!)
    }
}
