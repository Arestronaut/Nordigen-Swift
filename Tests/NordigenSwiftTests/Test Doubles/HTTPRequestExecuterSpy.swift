//
//  File.swift
//  
//
//  Created by Raoul Schwagmeier on 28.12.22.
//

import Foundation
@testable import NordigenSwift

final class HTTPRequestExecuterSpy: HTTPRequestExecuter {
    var recordedRequests: [URLRequest] = []
    var mockedError: Error?
    var mockedResponse: URLResponse = .init()
    var mockedData: Data = .init()
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        recordedRequests.append(request)
        if let mockedError {
            throw mockedError
        }
        
        return (mockedData, mockedResponse)
    }
}

