//
//  HealthCheckService.swift
//  PTVHealthCheck
//
//  Created by Vignesh Sankaran on 13/11/18.
//  Copyright © 2018 Vignesh Sankaran. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

public class HealthCheckService: NSObject {
    let healthCheckURL: URL
    let developerID: String
    let securityKey: String
    
    override init() {
        guard let APIQueryParamsPath = Bundle.main.path(forResource: "APIQueryParams", ofType: "plist") else {
            fatalError("APIQueryParams.plist not found!")
        }
        
        guard let APIQueryParams = NSDictionary(contentsOfFile: APIQueryParamsPath) else {
            fatalError("APIQueryParams.plist not found!")
        }
        
        healthCheckURL = URL(string: APIQueryParams["HealthCheckEndpoint"] as! String)!
        developerID = APIQueryParams["DeveloperID"] as! String
        securityKey = APIQueryParams["SecurityKey"] as! String
    }
    
    public func healthCheck(callback: () -> ()) {
        let _ = createURL()

        // Call Alamofire
    }
    
    private func createURL() -> String {
        let developerIDParam = URLQueryItem(name: "devid", value: developerID)
        var requestURL = URLComponents(url: healthCheckURL, resolvingAgainstBaseURL: false)!
        requestURL.queryItems = [developerIDParam]
        
        let hmacSignature = calculateHmac(baseURL: requestURL.string!)
        let timestamp = generateTimestamp()
        
        let hmacParam = URLQueryItem(name: "signature", value: hmacSignature)
        let timestampParam = URLQueryItem(name: "", value: timestamp)
        
        requestURL.queryItems = [developerIDParam, hmacParam, timestampParam]
        
        return requestURL.string!
    }
    
    func calculateHmac(baseURL: String) -> String {
        let hmacBytes: [UInt8]
        let urlBytes = baseURL.bytes

        do {
            hmacBytes = try HMAC(key: baseURL, variant: .sha1).authenticate(urlBytes)
        } catch {
            fatalError("Failed to generate HMAC signature for url: \(baseURL)")
        }

        return hmacBytes.toHexString()
    }
    
    private func generateTimestamp() -> String {
        // Create timestamp
        // return timestamp
        return ""
    }
}
