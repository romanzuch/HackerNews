//
//  StoriesView.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import SwiftUI

struct StoriesView: View {
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    @State private var selection: RequestType = .new
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TypePicker($selection)
                
                StoriesListView(selection: selection)
                
            }
            
            .navigationTitle("Stories")
        }
        
    }
}
