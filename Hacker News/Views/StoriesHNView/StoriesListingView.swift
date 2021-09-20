//
//  StoriesListingView.swift
//  Hacker News
//
//  Created by Roman on 20.09.21.
//

import SwiftUI

struct StoriesListingView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    var selectedCategory: StoryCategory
    
    init(cat: StoryCategory) {
        self.selectedCategory = cat
    }
    
    var body: some View {
        
        switch selectedCategory {
        case .new:
            StoriesList(StoryCategory.new)
                .environmentObject(networkManager)
        case .best:
            StoriesList(StoryCategory.best)
                .environmentObject(networkManager)
        case .top:
            StoriesList(StoryCategory.top)
                .environmentObject(networkManager)
        }
        
    }
}

struct StoriesList: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    var category: StoryCategory
    
    init(_ cat: StoryCategory) {
        self.category = cat
    }
    
    var body: some View {
        switch category {
        case .new:
            List {

                ForEach(networkManager.newStoryIDs, id: \.self) { id in
                    Group {
                        if networkManager.newStories.keys.contains(id) {
                            NavigationLink(
                                destination: DetailView(networkManager.newStories[id]!),
                                label: {
                                    ListElementView(networkManager.newStories[id]!)
                                })
                                .unredacted()
                        } else {
                            Text(networkManager.newStories.keys.contains(id) ? "\(networkManager.newStories[id]!.title)" : "ListElementPlaceholderText")
                                .redacted(reason: .placeholder)
                        }
                    }
                        .onAppear {
                            networkManager.requestStory(id, cat: .new)
                        }
                }
            }
            .onAppear {
                networkManager.request(.newStoriesURL)
            }
            
        case .best:
            List {

                ForEach(networkManager.bestStoryIDs, id: \.self) { id in
                    Group {
                        if networkManager.bestStories.keys.contains(id) {
                            NavigationLink(
                                destination: DetailView(networkManager.bestStories[id]!),
                                label: {
                                    ListElementView(networkManager.bestStories[id]!)
                                })
                                .unredacted()
                        } else {
                            Text(networkManager.bestStories.keys.contains(id) ? "\(networkManager.bestStories[id]!.title)" : "ListElementPlaceholderText")
                                .redacted(reason: .placeholder)
                        }
                    }
                        .onAppear {
                            networkManager.requestStory(id, cat: .best)
                        }
                }
            }
            .onAppear {
                networkManager.request(.bestStoriesURL)
            }
            
        case .top:
            List {

                ForEach(networkManager.topStoryIDs, id: \.self) { id in
                    Group {
                        if networkManager.topStories.keys.contains(id) {
                            NavigationLink(
                                destination: DetailView(networkManager.topStories[id]!),
                                label: {
                                    ListElementView(networkManager.topStories[id]!)
                                })
                                .unredacted()
                        } else {
                            Text(networkManager.topStories.keys.contains(id) ? "\(networkManager.topStories[id]!.title)" : "ListElementPlaceholderText")
                                .redacted(reason: .placeholder)
                        }
                    }
                        .onAppear {
                            networkManager.requestStory(id, cat: .top)
                        }
                }
            }
            .onAppear {
                networkManager.request(.topStoriesURL)
            }
        }
    }
}
