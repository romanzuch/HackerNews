//
//  StoryView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI
import LinkPresentation

struct StoryView: View {
    
    var url: String
    var title: String
    var commentCount: Int
    var score: Int
    
    init(story: Story) {
        self.url = story.url ?? ""
        self.title = story.title ?? ""
        self.commentCount = story.descendants ?? 0
        self.score = story.score ?? 0
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if title != "" {
                Text(title)
                    .fontWeight(.bold)
            } else {
                EmptyView()
            }
            
            if url != "" {
//                Link(url, destination: URL(string: url)!).font(.system(size: 12))
                Text(url)
                    .font(.system(size: 12))
            } else {
                EmptyView()
            }
            
            
            HStack {
                
                if score != 0 {
                    Label("\(score)", systemImage: "star")
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                } else {
                    EmptyView()
                }
                
                if commentCount != 0 {
                    Label("\(commentCount)", systemImage: "captions.bubble")
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                } else {
                    EmptyView()
                }
                
            }
        }
        
    }
}
