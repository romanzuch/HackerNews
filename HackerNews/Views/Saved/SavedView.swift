//
//  SavedView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI

struct SavedView: View {
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    var body: some View {
        NavigationView {
            Text("Saved")
                .navigationTitle("Saved Stories")
        }
    }
}
