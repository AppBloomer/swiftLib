//
//  WalinnsInstance.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 14/11/17.
//
//

import Foundation
#if !os(OSX)
    import UIKit
#else
    import Cocoa
#endif // os(OSX)

public protocol WalinnsDelegate {
    
}

protocol AppLifecycle {
    func applicationDidBecomeActive()
    func applicationWillResignActive()
}
