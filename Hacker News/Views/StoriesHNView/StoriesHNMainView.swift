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
            
            VStack {
                
                Picker("", selection: $selectedCategory) {
                    ForEach(StoryCategory.allCases, id: \.self) { cat in
                        Text(cat.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                switch selectedCategory {
                
                case .new:
                    StoriesListingView(cat: .new)
                        .environmentObject(networkManager)
                case .best:
                    StoriesListingView(cat: .best)
                        .environmentObject(networkManager)
                case .top:
                    StoriesListingView(cat: .top)
                        .environmentObject(networkManager)
                    
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
