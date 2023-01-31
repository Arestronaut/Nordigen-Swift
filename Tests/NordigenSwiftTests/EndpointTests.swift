//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import NordigenSwift

final class EndpointTests: XCTestCase {
    private var sut: Endpoint!
    private var spy: HTTPRequestExecuterSpy!

    override func setUp() {
        super.setUp()

        spy = .init()
        sut = .init(httpRequestExecuter: spy)
    }

    override func tearDown() {
        spy.clear()

        super.tearDown()
    }

    func test_GivenResponse_WhenGetWithoutReturn_ThenSucceed() {
        spy.mockedData = String("{}").data(using: .utf8)!
        spy.mockedResponse = .makeSuccessResponse()

        testAsync {
            try await self.sut.get(path: "")
        }
    }

    func test_GivenResponse_WhenGetWithReturn_ThenReturn() {
        spy.mockedData = String("{\"key\": \"something\"}").data(using: .utf8)!
        spy.mockedResponse = .makeSuccessResponse()

        testAsync {
            let response: [String:String] = try await self.sut.get(path: "")
            XCTAssert(response["key"] == "something")
        }
    }

    func test_GivenCustomData_WhenGetWithReturn_ThenReturnDecodedData() {
        struct Sample: Codable {
            var testProperty: String
        }

        spy.mockedData = try! Sample(testProperty: "regenbogenfisch").toJSON()
        spy.mockedResponse = .makeSuccessResponse()

        testAsync {
            let response: Sample = try await self.sut.get(path: "")
            XCTAssert(response.testProperty == "regenbogenfisch")
        }
    }

    func test_GivenFailedRequest_WhenGetWithoutReturn_ThenThrowStatusCodeError() {
        let errorResponse = StatusCodeResponse(detail: "SampleError", summary: "This is a testError", type: nil, statusCode: 400)

        spy.mockedData = try! errorResponse.toJSON()
        spy.mockedResponse = .makeClientErrorResponse()

        testAsyncThrowsError(assertError: Endpoint.NetworkingError.requestFailure(errorResponse)) {
            try await self.sut.get(path: "")
        }
    }

    func test_GivenFailedRequest_WhenGetWithoutReturn_ThenThrowUnknownError() {
        spy.mockedResponse = .makeClientErrorResponse()

        testAsyncThrowsError(assertError: Endpoint.NetworkingError.unkownRequestFailure("")) {
            try await self.sut.get(path: "")
        }
    }
}

