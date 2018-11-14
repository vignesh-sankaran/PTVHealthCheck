//
//  ViewModel.swift
//  PTVHealthCheck
//
//  Created by Vignesh Sankaran on 13/11/18.
//  Copyright © 2018 Vignesh Sankaran. All rights reserved.
//

import Foundation
import Alamofire

extension Notification.Name {
    static let SuccessfulResponse = NSNotification.Name("SuccessfulResponse")
}

class ViewModel {
    var clientClock: String?
    var securityToken: String?
    var memcache: String?
    var database: String?
    
    init() {
        clientClock = nil
        securityToken = nil
        memcache = nil
        database = nil
        
        HealthCheckService().healthCheck(callback: initVariables)
    }
    
    func initVariables(response: DataResponse<Any>) {
        guard response.response?.statusCode == 200 else {
            return
        }
        
        guard let JSONResponse = response.result.value as? NSDictionary else {
            return
        }
        
        clientClock = boolToText(value: JSONResponse["clientClockOK"] as! Bool)
        securityToken = boolToText(value: JSONResponse["securityTokenOK"] as! Bool)
        memcache = boolToText(value: JSONResponse["memcacheOK"] as! Bool)
        database = boolToText(value: JSONResponse["databaseOK"] as! Bool)
        
        NotificationCenter.default.post(name: .SuccessfulResponse, object: nil)
        print("Variables have been initialised!")
    }
    
    func boolToText(value: Bool) -> String {
        return value ? "OK" : "NOT OK"
    }
}
