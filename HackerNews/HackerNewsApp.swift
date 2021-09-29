//
//  HackerNewsApp.swift
//  HackerNews
//
//  Created by Roman on 27.09.21.
//

import SwiftUI

@main
struct HackerNewsApp: App {
    
    @StateObject var networkManager: NetworkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkManager)
        }
    }
}
