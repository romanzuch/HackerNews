//
//  StoryView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI
import LinkPresentation

struct StoryRowView: View {
    
    var url: String
    var title: String
    var commentCount: Int
    var score: Int
    
    init(story: Story) {
        self.url = story.url ?? ""
        self.title = story.title ?? ""
        self.commentCount = story.descendants ?? 0
        self.score = story.score ?? 0
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if title != "" {
                Text(title)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
            } else {
                Text("No title")
            }            
            
            StoryInfoBadgeView(score: score, count: commentCount)
            
        }
        
    }
}
