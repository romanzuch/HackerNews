//
//  ListElementView.swift
//  Hacker News
//
//  Created by Roman on 19.09.21.
//

import SwiftUI

struct ListElementView: View {
    
    var story: Story
    
    var body: some View {
        VStack {
            Text(story.title)
            HStack {
                Text(story.user)
                Text("\(story.comments.count)")
                Text("\(story.time)")
            }
        }
    }
}
