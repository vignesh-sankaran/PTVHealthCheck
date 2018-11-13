//
//  HealthCheckServiceTests.swift
//  PTVHealthCheckTests
//
//  Created by Vignesh Sankaran on 13/11/18.
//  Copyright © 2018 Vignesh Sankaran. All rights reserved.
//

import XCTest
@testable import PTVHealthCheck

class HealthCheckServiceTests: XCTestCase {
    let healthCheckService = HealthCheckService()
    
    public func testHmacCalculated() {
        let developerID = "1111111"
        let url = "http://timetableapi.ptv.vic.gov.au/v2/healthcheck?devid=\(developerID)"
        let hmac = healthCheckService.calculateHmac(baseURL: url)
        
        XCTAssertNotNil(hmac)
    }
    
    public func testURLCreated() {
        let requestURL = healthCheckService.createURL()
        let urlStruct = URL(string: requestURL)
        
        XCTAssertNotNil(urlStruct)
    }
}
