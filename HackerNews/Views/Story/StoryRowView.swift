//
//  StoryView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI
import LinkPresentation

struct StoryRowView: View {
    
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
                    .padding(.vertical, 10)
            } else {
                Text("No title")
            }            
            
            HStack {
                
                if score != 0 {
//                    Label("\(score)", systemImage: "star")
//                        .font(.system(size: 10))
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
}
