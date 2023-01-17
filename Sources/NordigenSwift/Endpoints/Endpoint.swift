//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation
import os

private let logger = Logger(subsystem: "nordigen_swift", category: "Endpoint")

public final class Endpoint {
    struct EmptyInput: Encodable {}
    struct EmptyOutput: Decodable {}
    
    public enum NetworkingError: Error {
        case faultyResponse
        case requestFailure(StatusCodeResponse)
        case unkownRequestFailure(String)
        case underlyingError(Error)
    }
    
    private var baseURL: String
    private var httpRequestExecuter: HTTPRequestExecuter
    
    public init(baseURL: String = "https://ob.nordigen.com/api/v2/", httpRequestExecuter: HTTPRequestExecuter = URLSession.shared) {
        self.baseURL = baseURL
        self.httpRequestExecuter = httpRequestExecuter
    }
    
    private var bearerToken: String?
    func setBearerToken(_ token: String?) {
        self.bearerToken = token
    }
    
    @discardableResult
    private func performRequest<OutputType: Decodable, InputType: Encodable>(
        httpMethod: String,
        path: String,
        bodyData: InputType,
        additionalHeaders: [String: String],
        queryParameters: [String: String]
    ) async throws -> OutputType {
        let input: Data = try JSONEncoder().encode(bodyData)
        
        let request = makeURLRequest(
            httpMethod: httpMethod,
            path: path,
            bodyData: input,
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )

        logger.debug("\(request.debugDescription)")
        
        let (outputData, response) = try await httpRequestExecuter.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.faultyResponse }

        switch httpResponse.statusCode {
        case 200..<300:
            return try JSONDecoder().decode(OutputType.self, from: outputData)
        default:
            if let statusCodeResponse = try? JSONDecoder().decode(StatusCodeResponse.self, from: outputData) {
                throw NetworkingError.requestFailure(statusCodeResponse)
            } else {
                let failureStrig = String(data: outputData, encoding: .utf8) ?? "Something went wrong"
                throw NetworkingError.unkownRequestFailure(failureStrig)
            }
        }
    }
    
    private func makeURLRequest(
        httpMethod: String,
        path: String,
        bodyData: Data,
        additionalHeaders: [String : String],
        queryParameters: [String : String]
    ) -> URLRequest {
        var requestURL = URL(string: self.baseURL + path)!
                
        if !queryParameters.isEmpty {
            let queryItems: [URLQueryItem] = queryParameters.map {
                .init(name: $0.key, value: String(describing: $0.value))
            }
            
            if #available(iOS 16.0, *) {
                requestURL.append(queryItems: queryItems)
            } else {
                var urlComponents = URLComponents(string: requestURL.absoluteString)!
                urlComponents.queryItems = queryItems
                
                requestURL = urlComponents.url!
            }
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod

        if httpMethod != "GET" {
            request.httpBody = bodyData
        }
        
        var headers: [String: String] = [
            "accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        if let bearerToken {
            headers["Authorization"] = "Bearer \(bearerToken)"
        }
        
        if !additionalHeaders.isEmpty {
            headers.merge(additionalHeaders, uniquingKeysWith: { first, _ in first })
        }
        
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return request
    }
}

// MARK: - GET
extension Endpoint {
    func `get`(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws {
        let _: EmptyOutput = try await performRequest(
            httpMethod: "GET",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func `get`<OutputType: Decodable>(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws -> OutputType {
        try await performRequest(
            httpMethod: "GET",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
}

// MARK: - POST
extension Endpoint {
    func post(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws {
        let _: EmptyOutput = try await performRequest(
            httpMethod: "POST",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func post<OutputType: Decodable>(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws -> OutputType {
        try await performRequest(
            httpMethod: "POST",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func post<InputType: Encodable>(
        path: String,
        input: InputType,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws {
        let _: EmptyOutput = try await performRequest(
            httpMethod: "POST",
            path: path,
            bodyData: input,
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func post<OutputType: Decodable, InputType: Encodable>(
        path: String,
        input: InputType,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws -> OutputType {
        try await performRequest(
            httpMethod: "POST",
            path: path,
            bodyData: input,
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
}

// MARK: - DELETE
extension Endpoint {
    func delete(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws {
        let _: EmptyOutput = try await performRequest(
            httpMethod: "DELETE",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func delete<OutputType: Decodable>(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws -> OutputType {
        try await performRequest(
            httpMethod: "DELETE",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func delete<InputType: Encodable>(
        path: String,
        input: InputType,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws {
        let _: EmptyOutput = try await performRequest(
            httpMethod: "DELETE",
            path: path,
            bodyData: input,
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func delete<OutputType: Decodable, InputType: Encodable>(
        path: String,
        input: InputType,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws -> OutputType {
        try await performRequest(
            httpMethod: "DELETE",
            path: path,
            bodyData: input,
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
}

// MARK: - PUT
extension Endpoint {
    func put(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws {
        let _: EmptyOutput = try await performRequest(
            httpMethod: "PUT",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func put<OutputType: Decodable>(
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws -> OutputType {
        try await performRequest(
            httpMethod: "PUT",
            path: path,
            bodyData: EmptyInput(),
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func put<InputType: Encodable>(
        path: String,
        input: InputType,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws {
        let _: EmptyOutput = try await performRequest(
            httpMethod: "PUT",
            path: path,
            bodyData: input,
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
    
    func put<OutputType: Decodable, InputType: Encodable>(
        path: String,
        input: InputType,
        additionalHeaders: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) async throws -> OutputType {
        try await performRequest(
            httpMethod: "PUT",
            path: path,
            bodyData: input,
            additionalHeaders: additionalHeaders,
            queryParameters: queryParameters
        )
    }
}
