
//
//  SocketConnection.swift
//  
//
//  Created by Muhammad Fatani on 12/12/2017.
//  Copyright © 2017 Muhammad Fatani. All rights reserved.
//

import Foundation

/// protocol for network problems
protocol SocketConnection {
    
    /// this method call when timeout is occur
    /// - Parameter message: message for user
    func onTimeoutOccur(message:String)
    
    
    /// this method call when unknown error occur
    ///
    /// - Parameter message: message for user
    func onUnknownHost(message: String)
}
