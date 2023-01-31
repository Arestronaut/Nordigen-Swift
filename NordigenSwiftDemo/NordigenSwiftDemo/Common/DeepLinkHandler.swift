//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Combine
import SwiftUI
import os

private let logger = Logger(subsystem: "nordigen_swift", category: "DeepLinkHandler")

enum DeepLink {
    case bankAuthenticationRedirect(institutionId: String)

    static func make(from url: URL) -> DeepLink? {
        guard let host = url.host() else { return nil }
        switch host {
        case "BankAuthenticationRedirect":
            let query = url.parsedQuery()
            guard let id = query["id"] else { return nil }
            return .bankAuthenticationRedirect(institutionId: id)
        default:
            return nil
        }
    }
}

final class DeepLinkHandler: ObservableObject {
    private let subject: PassthroughSubject<DeepLink, Never> = .init()
    lazy var publisher: AnyPublisher<DeepLink, Never> = subject.eraseToAnyPublisher()

    init() { }

    func handle(link: URL) {
        guard let deeplink = DeepLink.make(from: link) else {
            logger.error("Couldn't create deeplink from url: \(link.absoluteString)")
            return
        }

        subject.send(deeplink)
    }
}

