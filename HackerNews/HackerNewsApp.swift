//
//  HackerNewsApp.swift
//  HackerNews
//
//  Created by Roman on 27.09.21.
//

import SwiftUI

@main
struct HackerNewsApp: App {
    
    @StateObject var storyViewModel: StoryViewModel = StoryViewModel()
    @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    @StateObject var commentViewModel: CommentViewModel = CommentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storyViewModel)
                .environmentObject(settingsViewModel)
                .environmentObject(commentViewModel)
                .preferredColorScheme(settingsViewModel.getAppAppearance())
        }
    }
}
