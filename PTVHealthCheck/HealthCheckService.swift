//
//  HealthCheckService.swift
//  PTVHealthCheck
//
//  Created by Vignesh Sankaran on 13/11/18.
//  Copyright © 2018 Vignesh Sankaran. All rights reserved.
//

import Foundation
import Alamofire

public class HealthCheckService {
    let healthCheckURL: String
    let developerID: String
    let securityKey: String
    
    init() {
        guard let APIQueryParamsPath = Bundle.main.path(forResource: "APIQueryParams", ofType: "plist") else {
            fatalError("APIQueryParams.plist not found!")
        }
        
        guard let APIQueryParams = NSDictionary(contentsOfFile: APIQueryParamsPath) else {
            fatalError("APIQueryParams.plist not found!")
        }
        
        healthCheckURL = APIQueryParams["healthCheckURL"] as! String
        developerID = APIQueryParams["developerID"] as! String
        securityKey = APIQueryParams["securityKey"] as! String
    }
}
