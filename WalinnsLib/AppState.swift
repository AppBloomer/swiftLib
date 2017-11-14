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

class AppState: NSObject,AppLifecycle{
    
    let lock: ReadWriteLock
    var timer: Timer?
    var delegate: AppStateDelegate?
    var useIPAddressForGeoLocation = true
    var sessionLength: TimeInterval = 0
    var sessionStartTime: TimeInterval = Date().timeIntervalSince1970
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
    
    var _minimumSessionDuration: UInt64 = 10000
    var minimumSessionDuration: UInt64 {
        set {
            _minimumSessionDuration = newValue
        }
        get {
            return _minimumSessionDuration
        }
    }
    var _maximumSessionDuration: UInt64 = UINT64_MAX
    var maximumSessionDuration: UInt64 {
        set {
            _maximumSessionDuration = newValue
        }
        get {
            return _maximumSessionDuration
        }
    }


    required init(basePathIdentifier: String, lock: ReadWriteLock) {
        self.lock = lock
    }

    func applicationWillResignActive() {
        startFlushTimer()
        sessionLength = roundOneDigit(num: Date().timeIntervalSince1970 - sessionStartTime)
        if sessionLength >= Double(minimumSessionDuration / 1000) &&
            sessionLength <= Double(maximumSessionDuration / 1000) {
            print("Session_duration", sessionLength)
        }
        
    }

    func applicationDidBecomeActive() {
        sessionStartTime = Date().timeIntervalSince1970
         print("Session_start_time", sessionStartTime)
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
    func roundOneDigit(num: TimeInterval) -> TimeInterval {
        return round(num * 10.0) / 10.0
    }
    
}
 
