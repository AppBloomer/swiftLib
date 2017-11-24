//
//  TrackerDelegate.swift
//  Pods
//
//  Created by Walinns Innovation on 23/11/17.
//
//

import Foundation
import UIKit


class TrackerDelegate: UIResponder , UIApplicationDelegate {
    
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("App active state : " + "App launsh" )
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App active state : " + "App active" )
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App active state : " + "App bg" )
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
          print("App active state : " + "App Fg" )
    }
    
   
}
