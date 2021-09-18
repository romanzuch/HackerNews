//
//  NewStoriesHNView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct NewStoriesHNView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    
    var body: some View {
        List {
            ForEach(Array(networkManager.topStoriesDummy.enumerated()), id: \.offset) { index, story in
                NavigationLink(
                    destination:
                        DetailView(story)
                    ,
                    label: {
                        ListElementView(story)
                    })
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear {
            networkManager.request(.newStoriesURL)
        }
    }
}

struct NewStoriesHNView_Previews: PreviewProvider {
    static var previews: some View {
        NewStoriesHNView()
    }
}
