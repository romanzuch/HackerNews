//
//  ContentView.swift
//  HackerNews
//
//  Created by Roman on 27.09.21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @State private var tabSelection = 0
    
    var body: some View {
        
        // TabView
        TabView(selection: $tabSelection) {
            
            StoriesView()
                .tabItem {
                    Label("Stories", systemImage: "book.fill")
                }
                .tag(0)
                .environmentObject(networkManager)
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "star.fill")
                }
                .tag(1)
            
        }
        .task {
            await networkManager.request()
        }
        
    }
}
