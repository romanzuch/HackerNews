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
        
        ScrollView {
            VStack(alignment: .center) {
                
                Group {
                    if storyTitle != "" {
                        Text(storyTitle)
                            .fontWeight(.bold)
                            .font(.title)
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
            .toolbar {
                HStack {
                    Button {
                        ShareViewController().share(story.title, urlString: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    Button {
                        storyViewModel.saveStory(story)
                    } label: {
                        if storyViewModel.savedStories.contains(story) {
                            Image(systemName: "star.slash")
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        }
        
    }
}
