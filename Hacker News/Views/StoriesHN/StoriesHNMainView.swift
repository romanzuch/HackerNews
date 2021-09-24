//
//  StoriesHNMainView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct StoriesHNMainView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    @EnvironmentObject var userSettings: UserSettings
    @State private var selectedCategory: StoryCategory = .new
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SelectionPickerView($selectedCategory)
                
                switch selectedCategory {
                
                case .new:
                    StoriesListingView(cat: .new)
                        .environmentObject(networkManager)
                        .environmentObject(userSettings)
                    
                case .best:
                    StoriesListingView(cat: .best)
                        .environmentObject(networkManager)
                        .environmentObject(userSettings)
                    
                case .top:
                    StoriesListingView(cat: .top)
                        .environmentObject(networkManager)
                        .environmentObject(userSettings)
                    
                case .ask:
                    StoriesListingView(cat: .ask)
                        .environmentObject(networkManager)
                        .environmentObject(userSettings)
                    
                case .show:
                    StoriesListingView(cat: .show)
                        .environmentObject(networkManager)
                        .environmentObject(userSettings)
                    
                case .job:
                    StoriesListingView(cat: .job)
                        .environmentObject(networkManager)
                        .environmentObject(userSettings)
                    
                }
                
            }
            
            .navigationBarTitle("Stories")
            
        }
    }
}

//struct StoriesHNMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoriesHNMainView()
//    }
//}
