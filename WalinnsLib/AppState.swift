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

class AppState: AppLifecycle{
    
}
