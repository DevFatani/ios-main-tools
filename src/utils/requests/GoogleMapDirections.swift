//
//  FetchDirectionsRequest.swift
//
//  Created by Muhammad Fatani on 23/12/2017.
//  Copyright © 2017 Muhammad Fatani. All rights reserved.
//

import Alamofire
class GoogleMapDirections  : MainRequest {
   

   let GOOGLE_MAP_DIRCTIONS = "https://maps.googleapis.com/maps/api/directions/json?"
   
    /// set the url for request and setup parameters for request
    init(startLat: Double, startLng: Double, endLat: Double, endLng: Double) {
        super.init()
        let origin = "origin=\(startLat),\(startLng)&"
        let destination = "destination=\(endLat),\(endLng)&mode=driving"
        self.url = "\(GOOGLE_MAP_DIRCTIONS)\(origin)\(destination)"
    }
    
    
    var response: FetchDirectionsResponse?
    
    /// call to start the request
    override func start() {

        self.manager!.request(self.url!, method: .get,  encoding: JSONEncoding.default, headers: self.headers)
            .responseJSON { response in
               
                switch (response.result) {
               
                case .success(let value):
                  
                    if let dataDic = value as? NSDictionary /* || value as? NSArray */ {


                    }
                    
                    break
                    
                case .failure(let error):
                    
                    Logger.error(tag: "GoogleMapDirections", message: error)

                    self.socketConnection!.onUnknownHost(message: "ErrorUnknown")
                   
                    break
                }
        }
    }
    
}
