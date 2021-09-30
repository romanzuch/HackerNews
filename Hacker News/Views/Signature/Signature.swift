//
//  Signature.swift
//  Hacker News
//
//  Created by Roman on 25.09.21.
//

import SwiftUI

struct Signature: View {
    var body: some View {
        Text("Created by Roman Zuchowski")
            .font(.subheadline)
            .foregroundColor(Color(UIColor.systemGray3))
    }
}

struct Signature_Previews: PreviewProvider {
    static var previews: some View {
        Signature()
    }
}
