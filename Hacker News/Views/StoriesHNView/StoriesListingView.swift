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
            StoriesList(StoryCategory.new, style: .inset)
                .environmentObject(networkManager)
        case .best:
            StoriesList(StoryCategory.best, style: .inset)
                .environmentObject(networkManager)
        case .top:
            StoriesList(StoryCategory.top, style: .inset)
                .environmentObject(networkManager)
        }
        
    }
}

struct StoriesList<S>: View where S: ListStyle{
    
    @EnvironmentObject var networkManager: HNNetworkManager
    var category: StoryCategory
    var listStyle: S
    
    init(_ cat: StoryCategory, style: S) {
        self.category = cat
        self.listStyle = style
    }
    
    var body: some View {
        switch category {
        case .new:
            if #available(iOS 15, *) {
                List {

                    ForEach(networkManager.newStoryIDs, id: \.self) { id in
                        Group {
                            if networkManager.newStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.newStories[id]!)
                                        .environmentObject(networkManager)
                                    ,
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
                .refreshable {
                    networkManager.request(.newStoriesURL)
                }
                .listStyle(listStyle)
            } else {
                List {

                    ForEach(networkManager.newStoryIDs, id: \.self) { id in
                        Group {
                            if networkManager.newStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.newStories[id]!)
                                        .environmentObject(networkManager)
                                    ,
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
                .listStyle(listStyle)
            }
            
        case .best:
            if #available(iOS 15, *) {
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
                .refreshable {
                    networkManager.request(.bestStoriesURL)
                }
                .listStyle(listStyle)
            } else {
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
                .listStyle(listStyle)
            }
            
        case .top:
            if #available(iOS 15, *) {
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
                .refreshable {
                    networkManager.request(.topStoriesURL)
                }
                .listStyle(listStyle)
            } else {
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
                .listStyle(listStyle)
            }
        }
    }
}
