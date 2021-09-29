//
//  StoriesView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI

struct StoriesView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(networkManager.stories.new, id: \.self) { story in
                    NavigationLink(destination: {
                        Text("Destination")
                    }, label: {
                        StoryView(story: story)
                    })
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Stories")
        }
        
    }
}
