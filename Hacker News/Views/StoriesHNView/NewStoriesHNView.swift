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
        VStack {
            
            List {
                ForEach(Array(networkManager.topStoriesDummy.enumerated()), id: \.offset) { index, element in
                    Text(element.title)
                }
            }
            
        }
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
