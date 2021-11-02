//
//  ContentView.swift
//  HackerNews
//
//  Created by Roman on 27.09.21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection = 0
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        
        // TabView
        TabView(selection: $tabSelection) {
            
            StoriesView()
                .tabItem {
                    Label("Stories", systemImage: "book.fill")
                }
                .tag(0)
                .environmentObject(storyViewModel)
                .environmentObject(settingsViewModel)
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "star.fill")
                }
                .tag(1)
                .environmentObject(storyViewModel)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
                .environmentObject(settingsViewModel)
            
        }
        
    }
}
