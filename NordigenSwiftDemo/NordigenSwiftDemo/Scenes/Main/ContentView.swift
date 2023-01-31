//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import NordigenSwift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var deepLinkHandler: DeepLinkHandler
    @StateObject var viewModel: ContentViewModel

    var body: some View {
        NavigationStack {
            contentView
                .toolbar {
                    if viewModel.isConnectedToSandbox {
                        Button("Sandbox") {
                            viewModel.openSandboxView()
                        }
                        .foregroundColor(Color.black)
                        .font(.caption)
                    } else {
                        Button("Connect to sandbox") {
                            viewModel.connectToSandboxInstitution()
                        }
                        .foregroundColor(Color.black)
                        .font(.caption)
                    }
                }
                .navigationDestination(isPresented: $viewModel.isSandboxViewPresented) {
                    viewModel.sandboxView()
                }
        }
        .searchable(text: $viewModel.searchText)
        .showLoading("content_view.is_authentication_in_progress.alert.title", isLoading: $viewModel.isAuthenticationInProgress)
        .showLoading("content_view.is_loading_institutions.alert.title", isLoading: $viewModel.isLoadingInstitutions)
        .showLoading("content_view.connecting_to_sandbox.alert.title", isLoading: $viewModel.isConnectingToSandbox)
        .task(priority: .background, {
            await viewModel.authenticateIfNecessary()
            await viewModel.loadInstitutions()
        })
        .onReceive(deepLinkHandler.publisher) { deepLink in
            guard case .bankAuthenticationRedirect = deepLink else { return }
            viewModel.didConnectToInstitution()
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.institutions.isEmpty {
            Text("No Institutions")
        } else {
            List {
                ForEach(viewModel.institutions) { insitution in
                    InstitutionEntryView(institution: insitution)
                        .frame(maxWidth: .infinity, maxHeight: 128.0)
                        .overlay {
                            RoundedRectangle(cornerSize: .init(width: 12.0, height: 12.0))
                                .stroke(Color.black, lineWidth: 1.0)
                        }
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            viewModel.connectToSandboxInstitution()
                        }
                }
            }
            .listStyle(.plain)
            .refreshable {
                await viewModel.loadInstitutions()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(nordigenClient: .init()))
    }
}
