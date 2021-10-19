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
    
    init(story: Story) {
        self.story = story
    }
    
    var body: some View {
        List {
            ForEach(storyViewModel.storyComments, id: \.id) { comment in
                CommentView(comment: comment)
            }
        }
            .onAppear {
                storyViewModel.requestComments(commentIDs: self.story.kids ?? [])
            }
    }
    
}
