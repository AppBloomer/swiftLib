//
//  ReadWriteLock.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 14/11/17.
//
//

import Foundation

class ReadWriteLock  {
    let concurentQueue: DispatchQueue
    
    init(label: String) {
        self.concurentQueue = DispatchQueue(label: label, attributes: .concurrent)
    }
    
    func read(closure: () -> ()) {
        self.concurentQueue.sync {
            closure()
        }
    }
    
    func write(closure: () -> ()) {
        self.concurentQueue.sync(flags: .barrier, execute: {
            closure()
        })
    }

}
