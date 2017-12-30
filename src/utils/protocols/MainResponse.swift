//
//  MainResponse.swift
//  
//
//  Created by Muhammad Fatani on 12/12/2017.
//  Copyright © 2017 Muhammad Fatani. All rights reserved.
//

import Foundation

/// Delegate for network request
protocol MainResponse {
    
    /// this method is call when the request is success
    ///
    /// - Parameter message: message of successful request
    func onSuccess(message:String)
    
    /// the method is call when the request is fail
    ///
    /// - Parameter message: message of fail request
    func onFail(message:String)
}
