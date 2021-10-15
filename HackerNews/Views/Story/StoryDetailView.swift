//
//  StoryDetailView.swift
//  HackerNews
//
//  Created by Roman on 30.09.21.
//

import SwiftUI

struct StoryDetailView: View {
    
    var storyURL: String
    var storyTitle: String
    var storyCommentCount: Int
    var storyScore: Int
    var storyCommentIDs: [Int]
    
    @Environment(\.dismiss) var dismiss
    
    init(story: Story) {
        self.storyURL = story.url ?? ""
        self.storyTitle = story.title
        self.storyCommentCount = story.descendants ?? 0
        self.storyScore = story.score
        self.storyCommentIDs = story.kids ?? []
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if storyTitle != "" {
                Text(storyTitle)
                    .fontWeight(.bold)
            } else {
                EmptyView()
            }
            
            if storyURL != "" {
                Link(storyURL, destination: URL(string: storyURL)!).font(.system(size: 12))
            } else {
                EmptyView()
            }
            
            StoryInfoBadgeView(score: storyScore, count: storyCommentCount)
            
            CommentSectionView(storyCommentIDs: storyCommentIDs)
            
        }
        
    }
}
