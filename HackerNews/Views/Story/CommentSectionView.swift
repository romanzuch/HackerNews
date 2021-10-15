//
//  CommentSectionView.swift
//  HackerNews
//
//  Created by Roman on 15.10.21.
//

import SwiftUI

struct CommentSectionView: View {
    
    var storyCommentIDs: [Int]
    
    init(storyCommentIDs: [Int]) {
        // so apparently these are only the top level comments
        self.storyCommentIDs = storyCommentIDs
    }
    
    var body: some View {
        Text("\(storyCommentIDs.count)")
    }
}
