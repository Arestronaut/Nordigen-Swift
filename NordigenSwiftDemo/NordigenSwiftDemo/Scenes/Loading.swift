//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import SwiftUI

extension View {
    func showLoading(_ localisationKey: LocalizedStringKey, isLoading: Binding<Bool>) -> some View {
        modifier(LoadingModifier(localisationKey: localisationKey, isLoading: isLoading))
    }
}

struct LoadingModifier: ViewModifier {
    var localisationKey: LocalizedStringKey
    @Binding var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                content.blur(radius: 12.0)
                LoadingView(localisationKey: localisationKey)
                    .ignoresSafeArea(.all)
            } else {
                content
            }
        }
    }
}

struct LoadingView: View {
    var localisationKey: LocalizedStringKey

    var body: some View {
        VStack {
            ProgressView()
                .padding()

            Text(localisationKey)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8.0)
        .shadow(radius: 3.0)
    }
}
