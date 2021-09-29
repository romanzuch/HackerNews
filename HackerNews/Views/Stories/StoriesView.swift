//
//  StoriesView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI

struct StoriesView: View {
    
    @ObservedObject var storyVM: StoryViewModel = StoryViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(storyVM.newStories, id: \.self) { story in
                    NavigationLink(destination: {
                        Text(story.title)
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
