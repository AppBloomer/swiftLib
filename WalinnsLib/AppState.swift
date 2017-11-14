//
//  AppState.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 14/11/17.
//
//

import Foundation

protocol AppStateDelegate {
    func appstate(completion: (() -> Void)?)
    #if os(iOS)
    func updateNetworkActivityIndicator(_ on: Bool)
    #endif // os(iOS)
}

class AppState: AppLifeCycle{
    
    let lock: ReadWriteLock
    var timer: Timer?
    var delegate: AppStateDelegate?
    var useIPAddressForGeoLocation = true
    
    var flushOnBackground = true
    var _flushInterval = 0.0
    var flushInterval: Double {
        set {
            objc_sync_enter(self)
            _flushInterval = newValue
            objc_sync_exit(self)
            
            delegate?.appstate(completion: nil)
            startFlushTimer()
        }
        get {
            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            
            return _flushInterval
        }
    }

    required init(basePathIdentifier: String, lock: ReadWriteLock) {
        self.lock = lock
    }

    func applicationWillResignActive() {
        startFlushTimer()
    }

    func applicationDidBecomeActive() {
        stopFlushTimer()
    }
    func startFlushTimer() {
        stopFlushTimer()
        if flushInterval > 0 {
            DispatchQueue.main.async() {
                self.timer = Timer.scheduledTimer(timeInterval: self.flushInterval,
                                                  target: self,
                                                  selector: #selector(self.appstateSelector),
                                                  userInfo: nil,
                                                  repeats: true)
            }
        }
    }
    @objc func appstateSelector() {
        delegate?.appstate(completion: nil)
    }
    func stopFlushTimer() {
        if let timer = timer {
            DispatchQueue.main.async() {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
}
 
