//
//  DetailView.swift
//  Hacker News
//
//  Created by Roman on 19.09.21.
//

import SwiftUI

struct DetailView: View {
    
    var story: Story
    let dateFormatter = DateFormatter()
    var timeString: String
    
    init(_ story: Story) {
        self.story = story
        self.dateFormatter.timeStyle = DateFormatter.Style.short
        self.dateFormatter.dateStyle = DateFormatter.Style.short
        self.dateFormatter.timeZone = .current
        self.timeString = self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(story.time)))
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(story.user).font(.system(size: 10.0)).fontWeight(.bold)
                Text("\(story.comments.count) comment(s)").font(.system(size: 10.0))
                Text("\(self.timeString)").font(.system(size: 10.0))
            }
            Text(story.title)
            Spacer()
        }
        .navigationBarItems(trailing:
            Button(action: {
                print("starring")
            }, label: {
                Image(systemName: "star")
            })
        )
    }
}
