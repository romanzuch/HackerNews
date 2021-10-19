//
//  CommentView.swift
//  HackerNews
//
//  Created by Roman on 19.10.21.
//

import SwiftUI

struct CommentView: View {
    
    var commentAuthor: String
    var commentCount: Int
    var commentText: String
    
    init(comment: Comment) {
        self.commentAuthor = comment.by
        self.commentCount = comment.kids?.count ?? 0
        self.commentText = comment.text
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(commentAuthor)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                Label("\(commentCount)", systemImage: "captions.bubble")
                    .font(.system(size: 12))
            }
            Text(commentText)
                .font(.system(size: 12))
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: StoryViewModel().getTestComment())
    }
}
