//
//  NordigenSwiftDemoApp.swift
//  NordigenSwiftDemo
//
//  Created by Raoul Schwagmeier on 11.01.23.
//

import NordigenSwift
import SwiftUI

@main
struct NordigenSwiftDemoApp: App {
    @AppStorage(Constants.Keys.authenticationToken)
    var authenticationToken: AccessToken?

    let nordigenClient: NordigenClient

    init() {
        nordigenClient = NordigenClient()

        if let authenticationToken {
            nordigenClient.setAuthenticationToken(authenticationToken.access)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(nordigenClient: nordigenClient))
        }
    }
}

extension RawRepresentable where Self: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else { return "" }
        return result
    }
}

extension AccessToken: RawRepresentable {}
