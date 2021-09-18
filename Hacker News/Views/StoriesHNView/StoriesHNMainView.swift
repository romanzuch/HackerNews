//
//  StoriesHNMainView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct StoriesHNMainView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    @State private var selectedCategory: StoryCategory = .new
    
    var body: some View {
        
        NavigationView {
            switch selectedCategory {
            
            case .new:
                NewStoriesHNView()
                    .environmentObject(networkManager)
                    .navigationBarTitle("Stories")
                    .navigationBarItems(trailing:
                        MenuButton($selectedCategory)
                    )
            case .best:
                BestStoriesHNView()
                    .environmentObject(networkManager)
                    .navigationBarTitle("Stories")
                    .navigationBarItems(trailing:
                        MenuButton($selectedCategory)
                    )
            case .top:
                TopStoriesHNView()
                    .environmentObject(networkManager)
                    .navigationBarTitle("Stories")
                    .navigationBarItems(trailing:
                        MenuButton($selectedCategory)
                    )
                
            }
        }
    }
}

struct StoriesHNMainView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesHNMainView()
    }
}
