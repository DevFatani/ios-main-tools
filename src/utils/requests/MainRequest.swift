
//
//  MainRequest.swift
//
//  Created by Muhammad Fatani on 12/12/2017.
//  Copyright © 2017 Muhammad Fatani. All rights reserved.
//


import Alamofire
import Foundation

/// Base class for network requests and configuration
class MainRequest{
    
    
    /// needed for authorization
    var token:String? = nil
    
    /// Delegate object to response the result
    var mainResponse:MainResponse? = nil
    
    /// Delegate object to handle fail request
    var socketConnection:SocketConnection? = nil
    
    /// api url for request
    internal var url:String? = nil
    
    internal let TAG = "MainRequest.swift"
    
    /// needed to configuration headers
    internal var headers:HTTPHeaders? = nil
    
    /// almofire configuration
    internal var manager:SessionManager? = nil
    
    /// needed for send information in JSON format
    internal var parameters: Parameters? = nil
    
    init(token:String = "") {
        self.token = token
        self.headers = HTTPHeaders()
        self.headers!["Content-Type"] = "application/json"
        self.manager = Alamofire.SessionManager.default
        self.manager!.session.configuration.timeoutIntervalForRequest = 1220
    }
    
    /// function to start requset
    func start(){}
    
    
    
}
