//
//  AskHNMainView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct AskHNMainView: View {
    var body: some View {
        NavigationView {
            Text("ask")
                .navigationBarTitle("ask")
        }
    }
}

struct AskHNMainView_Previews: PreviewProvider {
    static var previews: some View {
        AskHNMainView()
    }
}
