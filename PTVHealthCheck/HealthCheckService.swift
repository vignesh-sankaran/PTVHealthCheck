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

// Credit to Leo Dabus et al, retrieved 13 November 2018 from https://stackoverflow.com/a/27062664/5891072
extension Formatter {
    static let ISO8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}

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
    
    public func healthCheck(callback: @escaping (_ response: DataResponse<Any>) -> ()) {
        let requestURL = createURL()
        
        Alamofire.request(requestURL).responseJSON { response in
            callback(response)
        }
    }
    
    func createURL() -> String {
        let developerIDParam = URLQueryItem(name: "devid", value: developerID)
        var requestURL = URLComponents(url: healthCheckURL, resolvingAgainstBaseURL: false)!
        requestURL.queryItems = [developerIDParam]
        
        let hmacSignature = calculateHmac(baseURL: requestURL.string!)
        let timestamp = Formatter.ISO8601.string(from: Date())
        
        let hmacParam = URLQueryItem(name: "signature", value: hmacSignature)
        let timestampParam = URLQueryItem(name: "timestamp", value: timestamp)
        
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
}
