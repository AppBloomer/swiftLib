//
//  AppState.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 14/11/17.
//
//

import Foundation
import UIKit
import CoreData

@UIApplicationMain
class AppState: UIResponder, UIApplicationDelegate{
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App state" , "active")
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App state" , "bg")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        print("App state" , "resign")
    }
    
}
 
