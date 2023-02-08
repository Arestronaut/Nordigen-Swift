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
    @AppStorage(Constants.Keys.authenticationToken) var authenticationToken: AccessToken?
    @AppStorage(Constants.Keys.sandboxRequisition) var sandboxRequisition: Requisition?

    @StateObject var deepLinkHandler = DeepLinkHandler()

    let nordigenClient: NordigenClient

    init() {
        nordigenClient = NordigenClient()

        authenticationToken = nil
        if let authenticationToken {
            nordigenClient.setAuthenticationToken(authenticationToken.access)
        }

        // Clear remove sandbox requisition
        sandboxRequisition = nil
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(nordigenClient: nordigenClient))
                .environmentObject(deepLinkHandler)
                .onOpenURL { url in
                    deepLinkHandler.handle(link: url)
                }
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
