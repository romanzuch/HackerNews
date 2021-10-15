//
//  StoryView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI
import LinkPresentation

struct StoryRowView: View {
    
    var storyURL: String
    var storyTitle: String
    var storyCommentCount: Int
    var storyScore: Int
    
    init(story: Story) {
        self.storyURL = story.url ?? ""
        self.storyTitle = story.title
        self.storyCommentCount = story.descendants ?? 0
        self.storyScore = story.score
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if storyTitle != "" {
                Text(storyTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
            } else {
                Text("No title")
            }            
            
            StoryInfoBadgeView(score: storyScore, count: storyCommentCount)
            
        }
        
    }
}
