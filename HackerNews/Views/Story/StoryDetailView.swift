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
    var storyAuthor: String
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var commentViewModel: CommentViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAlert = false
    
    init(story: Story) {
        self.story = story
        self.storyURL = story.url ?? ""
        self.storyTitle = story.title
        self.storyCommentCount = story.descendants ?? 0
        self.storyScore = story.score
        self.storyAuthor = story.by
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
                
                StoryInfoBadgeView(score: storyScore, count: storyCommentCount, author: storyAuthor)
                    .padding(.bottom, 4)
                
                CommentSectionView(story: story)
                    .environmentObject(storyViewModel)
                    .environmentObject(commentViewModel)
                
                Spacer()
                
            }
            .padding(.horizontal, 10)
            .alert(isPresented: $showingAlert) {
                AlertController(settingsViewModel: settingsViewModel, storyViewModel: storyViewModel).subscriptionAlert(story: story)
            }
            .toolbar {
                HStack {
                    Button {
                        ShareViewController().share(story.title, urlString: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    Button {
                        storyViewModel.saveStory(story, showAlert: $showingAlert)
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
