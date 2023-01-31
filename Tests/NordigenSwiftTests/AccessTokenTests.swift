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
        endpoint = .init(httpRequestExecuter: testExecutorSpy)
        client = .init(endpoint: endpoint)
        
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()

        testExecutorSpy.clear()
    }
    
    // Happy path
    func test_GivenAccessTokenRequest_WhenNoError_ThenAccessTokenResponse() {
        let accessToken = AccessToken(access: "ACCESS", accessExpires: 10, refresh: "REFRESH", refreshExpires: 10)
        
        testExecutorSpy.mockedData = try! JSONEncoder().encode(accessToken)
        testExecutorSpy.mockedResponse = .makeSuccessResponse()

        testAsync {
            let receivedAccessToken = try await self.client.TokenAPI.new(secretId: "", secretKey: "")
            XCTAssertEqual(accessToken, receivedAccessToken)
        }
    }
    
    func test_GivenAccessToken_WhenOutputMismatch_ThenReceiveError() {
        testExecutorSpy.mockedError = Endpoint.NetworkingError.faultyResponse

        testAsyncThrowsError {
            _ = try await self.client.TokenAPI.new(secretId: "", secretKey: "")
        }
    }

    // Happy Path
    func test_GivenToken_WhenRefresh_ThenAccessTokenResponse() {
        let accessToken = AccessToken(access: "ACCESS", accessExpires: 10, refresh: "REFRESH", refreshExpires: 10)
        testExecutorSpy.mockedData = try! JSONEncoder().encode(accessToken)
        testExecutorSpy.mockedResponse = .makeSuccessResponse()
        testAsync {
            let receivedAccessToken = try await self.client.TokenAPI.refresh(token: "")
            XCTAssert(receivedAccessToken == accessToken)
        }
    }
}
