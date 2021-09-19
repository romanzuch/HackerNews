//
//  DetailView.swift
//  Hacker News
//
//  Created by Roman on 19.09.21.
//

import SwiftUI
import SafariServices

struct DetailView: View {
    
    var story: Story
    let dateFormatter = DateFormatter()
    var timeString: String
    let formatter = RelativeDateTimeFormatter()
    let networkManager: HNNetworkManager = HNNetworkManager()
    
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
            // Header
            HStack {
                Text(story.user).font(.system(size: 10.0)).fontWeight(.bold)
                Text("\u{00B7}")
//                Text(story.comments.count != 1 ? "\(story.comments.count) comments" : "\(story.comments.count) comment").font(.system(size: 10.0))
                Text("\u{00B7}")
                Text("\(self.timeString)").font(.system(size: 10.0))
            }
            
            // Title
            Text(story.title)
            
            // URL
            Group {
                if (story.url != nil) {
                    Link(destination: URL(string: story.url!)!, label: {
                        Text(story.url!).font(.system(size: 10.0))
                    })
                } else {
                    EmptyView()
                }
            }
            
            // Comments
//            Group {
//                ForEach(story.comments, id: \.self) { comment in
//                    Text("\(networkManager.requestComment(comment).text)")
//                }
//            }
            Spacer()
        }
        .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    print("starring")
                }, label: {
                    Image(systemName: "star")
                })
                Button(action: {
                    print("starring")
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
        )
    }
}
