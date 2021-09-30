//
//  StoriesListView.swift
//  HackerNews
//
//  Created by Roman on 30.09.21.
//

import SwiftUI

struct StoriesListView: View {
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    var selection: RequestType
    @State private var showDetails: Bool = false
    
    init(selection: RequestType) {
        self.selection = selection
    }
    
    var body: some View {
        
        switch selection {
        case .new:
            VStack {
                List {
                    ForEach(storyViewModel.newStories, id: \.self.hashValue) { story in
                        NavigationLink(destination: {
                            StoryDetailView(story: story)
                        }, label: {
                            StoryRowView(story: story)
                        })
                    }
                }
                .onAppear {
                    storyViewModel.requestStoryIDs(type: .new)
                }
            }
            
        case .top:
            VStack {
                List {
                    ForEach(storyViewModel.topStories, id: \.self.hashValue) { story in
                        NavigationLink(destination: {
                            StoryDetailView(story: story)
                        }, label: {
                            StoryRowView(story: story)
                        })
                    }
                }
                .onAppear {
                    storyViewModel.requestStoryIDs(type: .top)
                }
                
            }
            
        case .best:
            VStack {
                List {
                    ForEach(storyViewModel.bestStories, id: \.self.hashValue) { story in
                        NavigationLink(destination: {
                            StoryDetailView(story: story)
                        }, label: {
                            StoryRowView(story: story)
                        })
                    }
                }
                .onAppear {
                    storyViewModel.requestStoryIDs(type: .best)
                }
                
            }
            
        }
        
    }
}
