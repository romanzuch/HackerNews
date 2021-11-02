//
//  CommentSectionView.swift
//  HackerNews
//
//  Created by Roman on 15.10.21.
//

import SwiftUI

struct CommentSectionView: View {
    
    let story: Story
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var commentViewModel: CommentViewModel
    
    init(story: Story) {
        self.story = story
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(storyViewModel.storyComments[story.id] ?? [], id: \.self) { comment in
                    CommentView(comment: comment, level: 0)
                        .environmentObject(storyViewModel)
                        .environmentObject(commentViewModel)
                }
            }
        }
        .onAppear {
            storyViewModel.requestComments(commentIDs: self.story.kids ?? [])
        }
    }
    
}
