//
//  SavedView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI

struct SavedView: View {
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(storyViewModel.savedStories, id: \.self) { story in
                    StoryRowView(story: story)
                }
                .onDelete(perform: storyViewModel.removeStory)
            }
            .toolbar(content: {
                EditButton()
            })
                .navigationTitle("Saved Stories")
        }
    }
}
