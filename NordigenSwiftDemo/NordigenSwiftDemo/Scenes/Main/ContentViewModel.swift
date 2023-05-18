//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import NordigenSwift
import SwiftUI
import UIKit

@MainActor
final class ContentViewModel: ObservableObject {
    @AppStorage(Constants.Keys.authenticationTokenCreated) private var authenticationTokenCreated: Date?
    @AppStorage(Constants.Keys.authenticationToken) private var authenticationToken: AccessToken?
    @AppStorage(Constants.Keys.sandboxRequisition) private var sandboxRequisition: Requisition?

    @Published var isAuthenticated: Bool = false
    @Published var isAuthenticationInProgress: Bool = false

    @Published var isLoadingInstitutions: Bool = false
    @Published var institutions: [Institution] = []

    private var allInstitutions: [Institution] = [] {
        didSet {
            updateVisibleInstitutions()
        }
    }

    var searchText: String = "" {
        didSet {
            updateVisibleInstitutions()
        }
    }

    @Published var isConnectedToSandbox: Bool = false
    @Published var isConnectingToSandbox: Bool = false

    @Published var isSandboxViewPresented: Bool = false

    private let nordigenClient: NordigenClient

    init(nordigenClient: NordigenClient) {
        self.nordigenClient = nordigenClient
        self.isAuthenticated = authenticationToken != nil
        self.isConnectedToSandbox = sandboxRequisition != nil
    }

    func authenticateIfNecessary() async {
        guard authenticationToken == nil else {
            guard let authenticationTokenCreated else {
                authenticationToken = nil
                return await authenticateIfNecessary()
            }

            let accessExpires = TimeInterval(authenticationToken!.accessExpires)
            if Date(timeInterval: accessExpires, since: authenticationTokenCreated) <= Date() {
                authenticationToken = nil
                return await authenticateIfNecessary()
            }

            return
        }

        isAuthenticationInProgress = true

        do {
            authenticationTokenCreated = Date()

            authenticationToken = try await nordigenClient.TokenAPI.new(
                secretId: <#SecretID#>,
                secretKey: <#SecretKey#>
            )


            nordigenClient.setAuthenticationToken(authenticationToken?.access)

            isAuthenticated = true
            isAuthenticationInProgress = false
        } catch {
            isAuthenticationInProgress = false

            guard let error = error as? Endpoint.NetworkingError else { return }
            guard case let .requestFailure(statusCode) = error else { return }
            print(statusCode.description)
        }
    }

    func loadInstitutions() async {
        guard isAuthenticated else { return }

        isLoadingInstitutions = true
        do {
            allInstitutions = try await nordigenClient.InstitutionsAPI.all(
                country: Locale.current.language.region?.identifier ?? "DE",
                paymentsEnabled: false)

            isLoadingInstitutions = false
        } catch {
            isLoadingInstitutions = false
            print(error)
        }
    }

    func connectToInstitution(id: String? = nil) {
        isConnectingToSandbox = true

        let institutionId = id ?? "SANDBOXFINANCE_SFIN0000"

        Task {
            do {
                let requisition = try await nordigenClient.RequisitionsAPI.new(
                    .init(institutionId: institutionId,
                          redirect: "NordigenSwiftDemo://BankAuthenticationRedirect?id=\(institutionId)"))
                sandboxRequisition = requisition
                guard let link = URL(string: requisition.link) else { return }
                _ = await UIApplication.shared.open(link)
            } catch {
                print(error)
                isConnectingToSandbox = false
            }
        }
    }

    func didConnectToInstitution() {
        guard let id = sandboxRequisition?.id else { return }

        Task {
            do {
                let requisition = try await nordigenClient.RequisitionsAPI.get(id: id)
                guard requisition.status == .linked else { return }

                sandboxRequisition = requisition
                isConnectedToSandbox = true
                isConnectingToSandbox = false
            } catch {
                print(error)
                isConnectingToSandbox = false
            }
        }
    }

    func openSandboxView() {
        isSandboxViewPresented = true
    }

    func sandboxView() -> SandboxView {
        .init(viewModel: .init(nordigenClient: self.nordigenClient))
    }

    private func updateVisibleInstitutions() {
        institutions = searchText.isEmpty ? allInstitutions : allInstitutions.filter { $0.name.contains(searchText) }
    }
}

extension Institution: Identifiable {}
