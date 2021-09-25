//
//  ContextMenu.swift
//  Hacker News
//
//  Created by Roman on 25.09.21.
//

import SwiftUI

struct ContextMenu: View {
    
    var story: Story
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Button(action: {
            if (userSettings.savedStoryIDs.contains(story.id)) {
                userSettings.removeStoryFromDefaults(story)
            } else {
                userSettings.saveStoryToDefaults(story, time: Date())
            }
        }, label: {
            if (userSettings.savedStoryIDs.contains(story.id)) {
                Label("Unsave", systemImage: "star.fill")
            } else {
                Label("Save", systemImage: "star")
            }
        })
        
        Button(action: {
            if (story.url != nil) {
                openURL(URL(string: story.url!)!)
            } else {
                return
            }
        }, label: {
            if (story.url != nil) {
                Label("Open link", systemImage: "globe")
            } else {
                Text("No URL provided.")
            }
        })
        
        Button {
            
            ShareViewController().share(story.title, urlString: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")
            
        } label: {
            
            Label("Share", systemImage: "square.and.arrow.up")
            
        }
    }
}
