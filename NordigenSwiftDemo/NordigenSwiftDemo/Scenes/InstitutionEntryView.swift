//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import NordigenSwift
import SwiftUI

struct InstitutionEntryView: View {
    let institution: Institution

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: institution.logo)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128.0, alignment: .center)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading, spacing: 16.0) {
                Text(institution.name)
                Text(institution.bic)
            }

            Spacer()
        }
        .padding()
    }
}
