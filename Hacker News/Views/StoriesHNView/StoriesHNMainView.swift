//
//  StoriesHNMainView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct StoriesHNMainView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    @State private var selectedCategory: StoryCategories = .new
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                switch selectedCategory {
                
                case .new:
                    NewStoriesHNView()
                        .environmentObject(networkManager)
                case .best:
                    BestStoriesHNView()
                        .environmentObject(networkManager)
                case .top:
                    TopStoriesHNView()
                        .environmentObject(networkManager)
                    
                }
                
                Spacer()
                
            }
            .navigationBarTitle("Stories")
            .navigationBarItems(trailing:
                Menu {
                    
                    Button(action: {
                        selectedCategory = .new
                    }, label: {
                        if selectedCategory == .new {
                            Label("New", systemImage: "checkmark")
                        } else {
                            Text("New")
                        }
                    })
                    
                    Button(action: {
                        selectedCategory = .best
                    }, label: {
                        if selectedCategory == .best {
                            Label("Best", systemImage: "checkmark")
                        } else {
                            Text("Best")
                        }
                    })
                    
                    Button(action: {
                        selectedCategory = .top
                    }, label: {
                        if selectedCategory == .top {
                            Label("Top", systemImage: "checkmark")
                        } else {
                            Text("Top")
                        }
                    })
                    
                } label: {
                    
                    Image(systemName: "switch.2")
                    
                }
            )
        }
    }
}

struct StoriesHNMainView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesHNMainView()
    }
}
