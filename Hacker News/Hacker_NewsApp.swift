//
//  Hacker_NewsApp.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

@main
struct Hacker_NewsApp: App {
    
    @StateObject var networkManager: HNNetworkManager = HNNetworkManager()
    @StateObject var userSettings: UserSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkManager)
                .environmentObject(userSettings)
        }
    }
}
