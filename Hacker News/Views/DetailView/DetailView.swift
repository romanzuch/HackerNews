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
    @EnvironmentObject var networkManager: HNNetworkManager
    
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
                Group {
                    if (story.comments != nil) {
                        Text(story.comments!.count != 1 ? "\(story.comments!.count) comments" : "\(story.comments!.count) comment").font(.system(size: 10.0))
                    } else {
                        Text("0 comments").font(.system(size: 10.0))
                    }
                }
                Text("\u{00B7}")
                Text("\(self.timeString)").font(.system(size: 10.0))
            }
            
            // Title
            Text(story.title)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            
            // URL
            Group {
                if (story.url != nil) {
                    Link(destination: URL(string: story.url!)!, label: {
                        Text(story.url!).font(.system(size: 10.0))
                            .padding(.horizontal, 10)
                    })
                } else {
                    EmptyView()
                }
            }
            
            // Comments
            Group {
                if (story.comments != nil) {
                    ScrollView {
                        ForEach(story.comments!, id: \.self) { id in
                            Group {
                                if networkManager.storyComments.keys.contains(id) {
                                    Text("\(networkManager.storyComments[id]!.text)")
                                        .font(.system(size: 10.0))
                                        .padding(.all, 10)
                                        .unredacted()
                                } else {
                                    Text(networkManager.storyComments.keys.contains(id) ? "\(networkManager.storyComments[id]!.text)" : "This could be a comment...")
                                        .font(.system(size: 10.0))
                                        .padding(.all, 10)
                                        .redacted(reason: .placeholder)
                                }
                            }
                        }
                    }
                    
                    .onAppear {
                        networkManager.requestComments(story.comments!)
                    }
                    
                } else {
                    Text("No comments so far...")
                }
            }
            
            
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
