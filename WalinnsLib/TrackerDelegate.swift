//
//  TrackerDelegate.swift
//  Pods
//
//  Created by Walinns Innovation on 23/11/17.
//
//

import Foundation
import UIKit

public class TrackerDelegate: UIResponder , UIApplicationDelegate {
    
    
   public func applicationDidFinishLaunching(_ application: UIApplication) {
        print("App active state : " + "App launsh" )
    }
    
   public func applicationDidBecomeActive(_ application: UIApplication) {
        print("App active state : " + "App active" )
    }
    
   public func applicationDidEnterBackground(_ application: UIApplication) {
        print("App active state : " + "App bg" )
    }
    
   public func applicationWillEnterForeground(_ application: UIApplication) {
          print("App active state : " + "App Fg" )
    }
    
   
}
