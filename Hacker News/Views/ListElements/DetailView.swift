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
    let formatter = RelativeDateTimeFormatter()
    
    init(_ story: Story) {
        self.story = story
        self.dateFormatter.timeStyle = DateFormatter.Style.short
        self.dateFormatter.dateStyle = DateFormatter.Style.short
        self.dateFormatter.timeZone = .current
        self.dateFormatter.timeZone = .current
        formatter.unitsStyle = .short
        self.timeString = formatter.localizedString(for: Date(timeIntervalSince1970: TimeInterval(story.time)), relativeTo: Date())
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(story.user).font(.system(size: 10.0)).fontWeight(.bold)
                Text("\u{00B7}")
                Text(story.comments.count != 1 ? "\(story.comments.count) comments" : "\(story.comments.count) comment").font(.system(size: 10.0))
                Text("\u{00B7}")
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
