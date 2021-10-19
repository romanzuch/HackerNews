//
//  StoryDetailView.swift
//  HackerNews
//
//  Created by Roman on 30.09.21.
//

import SwiftUI

struct StoryDetailView: View {
    
    var story: Story
    var storyURL: String
    var storyTitle: String
    var storyCommentCount: Int
    var storyScore: Int
    var storyCommentIDs: [Int]
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Environment(\.dismiss) var dismiss
    
    init(story: Story) {
        self.story = story
        self.storyURL = story.url ?? ""
        self.storyTitle = story.title
        self.storyCommentCount = story.descendants ?? 0
        self.storyScore = story.score
        self.storyCommentIDs = story.kids ?? []
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Group {
                if storyTitle != "" {
                    Text(storyTitle)
                        .fontWeight(.bold)
                } else {
                    EmptyView()
                }
            }
            .padding(.bottom, 12)
            
            Group {
                if storyURL != "" {
                    Link(storyURL, destination: URL(string: storyURL)!).font(.system(size: 12))
                } else {
                    EmptyView()
                }
            }
            .padding(.bottom, 12)
            
            StoryInfoBadgeView(score: storyScore, count: storyCommentCount)
                .padding(.bottom, 4)
            
            CommentSectionView(story: story)
                .environmentObject(storyViewModel)
            
            Spacer()
            
        }
        .padding(.horizontal, 10)
        
    }
}
