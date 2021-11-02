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
    var subComments: [Int]
    var commentID: Int
    var commentLevel: Int
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var commentViewModel: CommentViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @State private var showSubComments: Bool = false
    
    init(comment: Comment, level: Int) {
        self.commentAuthor = comment.by ?? ""
        self.commentCount = comment.kids?.count ?? 0
        self.commentText = comment.text ?? ""
        self.subComments = comment.kids ?? []
        self.commentID = comment.id
        self.commentLevel = level
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(commentAuthor)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                Group {
                    if (subComments.count != 0) {
                        Button {
                            debugPrint(showSubComments ? "Hiding subcomments" : "Showing subcomments")
                            showSubComments.toggle()
                        } label: {
                            Label("\(commentCount)", systemImage: "captions.bubble")
                                .font(.system(size: 12))
                        }
                    } else {
                        Label("\(commentCount)", systemImage: "captions.bubble")
                            .font(.system(size: 12))
                    }
                }

            }
            .padding(.bottom, 4)
            Text(commentText)
                .font(.system(size: 12))
            
            // here are the sub-comments if present
            
        }
        .border(width: 4, edges: [.leading], color: commentViewModel.getCommentMarkerColor(commentLevel: commentLevel, settingsViewModel: settingsViewModel), padding: 12)
        .padding(.horizontal, 4)
        
        Group {
            if (subComments.count != 0) {
                
                if ( showSubComments == true ) {
                    ForEach(storyViewModel.storyComments[commentID] ?? [], id: \.self) { subComment in
                        CommentView(comment: subComment, level: commentLevel + 1)
                            .padding(.leading, 12)
                    }
                }
                
            } else { EmptyView() }
        }
    }
}

