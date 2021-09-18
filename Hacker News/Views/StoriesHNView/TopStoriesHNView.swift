//
//  TopStoriesHNView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct TopStoriesHNView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    
    var body: some View {
        VStack {
            Text("Top")
            Text("\(networkManager.topStoryIDs.count != 0 ? String(networkManager.topStoryIDs[0]) : "")")
        }
        .onAppear {
            networkManager.request(.topStoriesURL)
        }
    }
}

struct TopStoriesHNView_Previews: PreviewProvider {
    static var previews: some View {
        TopStoriesHNView()
    }
}
