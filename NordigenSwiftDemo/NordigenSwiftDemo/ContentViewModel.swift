//
//  ContentViewModel.swift
//  NordigenSwiftDemo
//
//  Created by Raoul Schwagmeier on 15.01.23.
//

import NordigenSwift
import SwiftUI

@MainActor
final class ContentViewModel: ObservableObject {
    @AppStorage(Constants.Keys.authenticationToken)
    var authenticationToken: AccessToken?

    @Published var isAuthenticated: Bool = false

    private let nordigenClient: NordigenClient

    init(nordigenClient: NordigenClient) {
        self.nordigenClient = nordigenClient
        self.isAuthenticated = authenticationToken != nil
    }

    func authenticateIfNecessary() async throws {
        guard authenticationToken == nil else { return }
        authenticationToken = try await nordigenClient.TokenAPI.new(
            secretId: <#secretId#>,
            secretKey: <#secretKey#>
        )
        isAuthenticated = true
    }
}
