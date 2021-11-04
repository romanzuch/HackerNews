//
//  StoryInfoBadgeView.swift
//  HackerNews
//
//  Created by Roman on 30.09.21.
//

import SwiftUI

struct StoryInfoBadgeView: View {
    
    private var score: Int
    private var commentCount: Int
    private var author: String
    
    init(score: Int, count: Int, author: String) {
        self.score = score
        self.commentCount = count
        self.author = author
    }
    
    var body: some View {
        HStack {
            
            Group {
                HStack {
                    Text(author)
                    Text("⋅")
                }
                .font(.system(size: 10))
            }
            
            if score != 0 {
                HStack{
                    Image(systemName: "star")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text("\(score)")
                        .font(.system(size: 10))
                }
            } else {
                Image(systemName: "star")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 10, height: 10)
                Text("0")
                    .font(.system(size: 10))
            }
            
            if commentCount != 0 {
                Image(systemName: "captions.bubble")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 10, height: 10)
                Text("\(commentCount)")
                    .font(.system(size: 10))
            } else {
                Image(systemName: "captions.bubble")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 10, height: 10)
                Text("0")
                    .font(.system(size: 10))
            }
            
        }
    }
}
