//
//  File.swift
//  
//
//  Created by Raoul Schwagmeier on 28.12.22.
//

import XCTest
@testable import NordigenSwift

final class AccessTokenTests: XCTestCase {
    var client: NordigenClient!
    var endpoint: Endpoint!
    var testExecutorSpy: HTTPRequestExecuterSpy!
    
    override func setUp() {
        testExecutorSpy = .init()
        endpoint = .init( httpRequestExecuter: testExecutorSpy)
        client = .init(endpoint: endpoint)
        
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Happy path
    func test_GivenAccessTokenRequest_WhenNoError_ThenAccessTokenResponse() {
        let accessToken = AccessToken(access: "ACCESS", accessExpires: 10, refresh: "REFRESH", refreshExpires: 10)
        
        testExecutorSpy.mockedData = try! JSONEncoder().encode(accessToken)
        
        Task {
            
            let receivedAccessToken = try await client.TokenAPI.new(secretId: "", secretKey: "")
            XCTAssertEqual(accessToken, receivedAccessToken)
        }
    }
    
//    func test_GivenAccessToken_WhenOutputMismatch_ThenReceiveError() {
//        let accessToken = AccessToken(access: "ACCESS", accessExpires: 10, refresh: "REFRESH", refreshExpires: 10)
//        testExecutorSpy.mockedData = try! JSONEncoder().encode(accessToken)
//        
//        Task {
//            let _:  try await client.TokenAPI.new(secretId: "", secretKey: "")
//        }
//    }
}

