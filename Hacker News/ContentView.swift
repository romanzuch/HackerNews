//
//  ContentView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabSelection = 0
    @EnvironmentObject var networkManager: HNNetworkManager
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            StoriesHNMainView()
                .tabItem {
                    if tabSelection == 0 {
                        Label("Stories", systemImage: "books.vertical.fill")
                    } else {
                        Label("Stories", systemImage: "books.vertical")
                    }
                }.tag(0)
                .environmentObject(networkManager)
            
            AskHNMainView()
                .tabItem {
                    if tabSelection == 1 {
                        Label("Ask", systemImage: "bubble.left.and.bubble.right.fill")
                    } else {
                        Label("Ask", systemImage: "bubble.left.and.bubble.right")
                    }
                }.tag(1)
            
            ShowHNMainView()
                .tabItem {
                    if tabSelection == 2 {
                        Label("Show", systemImage: "eye.fill")
                    } else {
                        Label("Show", systemImage: "eye")
                    }
                }.tag(2)
            
            JobsHNMainView()
                .tabItem {
                    if tabSelection == 3 {
                        Label("Jobs", systemImage: "graduationcap.fill")
                    } else {
                        Label("Jobs", systemImage: "graduationcap")
                    }
                }.tag(3)
            
            SettingsHNMainView()
                .tabItem {
                    if tabSelection == 4 {
                        Label("Settings", systemImage: "gearshape.fill")
                    } else {
                        Label("Settings", systemImage: "gearshape")
                    }
                }.tag(4)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(HNNetworkManager())
    }
}
