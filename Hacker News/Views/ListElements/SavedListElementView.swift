//
//  SavedListElementView.swift
//  Hacker News
//
//  Created by Roman on 24.09.21.
//

import SwiftUI

struct SavedListElementView: View {
    
    var story: Story
    let dateFormatter = DateFormatter()
    var timeString: String
    let formatter = RelativeDateTimeFormatter()
    
    init(_ story: SavedStory) {
        self.story = story.story
        self.dateFormatter.timeStyle = DateFormatter.Style.short
        self.dateFormatter.dateStyle = DateFormatter.Style.short
        self.dateFormatter.timeZone = .current
        formatter.unitsStyle = .short
        self.timeString = self.dateFormatter.string(from: story.time)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(story.title).font(.system(size: 14.0)).lineLimit(1)
            HStack {
                Text(story.user).font(.system(size: 10.0)).fontWeight(.bold)
                Text("\u{00B7}")
                Text("\(self.timeString)").font(.system(size: 10.0))
            }
            HStack {
                Text(story.score != 1 ? "\(story.score) points" : "\(story.score) point").font(.system(size: 10.0))
                Text("\u{00B7}")
                Group {
                    if (story.comments != nil) {
                        Text(story.comments!.count != 1 ? "\(story.comments!.count) comments" : "\(story.comments!.count) comment").font(.system(size: 10.0))
                    } else {
                        Text("0 comments").font(.system(size: 10.0))
                    }
                }
                Text("\u{00B7}")
                Text("Saved: \(timeString)").font(.system(size: 10.0))
            }
        }
    }
}
