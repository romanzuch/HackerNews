//
//  JobsHNMainView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct JobsHNMainView: View {
    var body: some View {
        NavigationView {
            Text("jobs")
            .navigationBarTitle("jobs")
        }
    }
}

struct JobsHNMainView_Previews: PreviewProvider {
    static var previews: some View {
        JobsHNMainView()
    }
}
