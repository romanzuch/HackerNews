//
//  BestStoriesHNView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct BestStoriesHNView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    
    var body: some View {
        VStack {
            Text("Best")
            Text("\(networkManager.bestStoryIDs.count != 0 ? String(networkManager.bestStoryIDs[0]) : "")")
        }
        .onAppear {
            networkManager.request(.bestStoriesURL)
        }
    }
}

struct BestStoriesHNView_Previews: PreviewProvider {
    static var previews: some View {
        BestStoriesHNView()
    }
}
