//
//  ContentView.swift
//  NordigenSwiftDemo
//
//  Created by Raoul Schwagmeier on 11.01.23.
//

import NordigenSwift
import SwiftUI

struct ContentView: View {
    @ObservedObject
    var viewModel: ContentViewModel

    var body: some View {
        VStack {
            Text(viewModel.isAuthenticated ? "Authenticated" : "Not authenticated")
        }
        .padding()
        .task {
            do {
               try await viewModel.authenticateIfNecessary()
            } catch {
                guard let error = error as? Endpoint.NetworkingError else { return }
                guard case let .underlyingError(underlyingError) = error,
                      let underlyingError = underlyingError as? Endpoint.NetworkingError else { return }
                guard case let .requestFailure(statusCode) = underlyingError else { return }
                print(statusCode.description)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(nordigenClient: .init()))
    }
}
