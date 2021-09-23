//
//  SavedHNMainView.swift
//  Hacker News
//
//  Created by Roman on 23.09.21.
//

import SwiftUI

struct SavedHNMainView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var networkManager: HNNetworkManager
    let savedStoryIDs: Array<Int>
    
    init(_ userSettings: UserSettings) {
        self.savedStoryIDs = userSettings.defaults.object(forKey: "savedStoryIDs") as? [Int] ?? [Int]()
    }
    
    var body: some View {
        NavigationView {
            Group {
                if (savedStoryIDs.count != 0) {
                    List {
                        ForEach(self.savedStoryIDs, id: \.self) { id in
                            Text("\(id)")
                        }
                    }
                    .listStyle(InsetListStyle())
                } else {
                    Text("No stories saved.")
                }
                
            }
            .navigationBarTitle("saved")
        }
    }
}
