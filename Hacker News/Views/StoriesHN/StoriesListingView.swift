//
//  StoriesListingView.swift
//  Hacker News
//
//  Created by Roman on 20.09.21.
//

import SwiftUI

struct StoriesListingView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    @EnvironmentObject var userSettings: UserSettings
    var selectedCategory: StoryCategory
    
    init(cat: StoryCategory) {
        self.selectedCategory = cat
    }
    
    var body: some View {
        
        switch selectedCategory {
        case .new:
            StoriesList(StoryCategory.new, style: .inset)
                .environmentObject(networkManager)
                .environmentObject(userSettings)
            
        case .best:
            StoriesList(StoryCategory.best, style: .inset)
                .environmentObject(networkManager)
                .environmentObject(userSettings)
            
        case .top:
            StoriesList(StoryCategory.top, style: .inset)
                .environmentObject(networkManager)
                .environmentObject(userSettings)
            
        case .ask:
            StoriesList(StoryCategory.ask, style: .inset)
                .environmentObject(networkManager)
                .environmentObject(userSettings)
            
        case .show:
            StoriesList(StoryCategory.show, style: .inset)
                .environmentObject(networkManager)
                .environmentObject(userSettings)
            
        case .job:
            StoriesList(StoryCategory.job, style: .inset)
                .environmentObject(networkManager)
                .environmentObject(userSettings)
        }
        
    }
}

struct StoriesList<S>: View where S: ListStyle{
    
    @EnvironmentObject var networkManager: HNNetworkManager
    @EnvironmentObject var userSettings: UserSettings
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
                                        .environmentObject(userSettings)
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
                                        .environmentObject(userSettings)
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
                                    destination: DetailView(networkManager.bestStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
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
                                    destination: DetailView(networkManager.bestStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
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
                                    destination: DetailView(networkManager.topStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
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
                                    destination: DetailView(networkManager.topStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
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
            
        case .ask:
            if #available(iOS 15, *) {
                List {

                    ForEach(networkManager.askStoryIDs, id: \.self) { id in
                        Group {
                            if networkManager.askStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.askStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        ListElementView(networkManager.askStories[id]!)
                                    })
                                    .unredacted()
                            } else {
                                Text(networkManager.askStories.keys.contains(id) ? "\(networkManager.askStories[id]!.title)" : "ListElementPlaceholderText")
                                    .redacted(reason: .placeholder)
                            }
                        }
                            .onAppear {
                                networkManager.requestStory(id, cat: .ask)
                            }
                    }
                }
                .onAppear {
                    networkManager.request(.askStoriesURL)
                }
                .refreshable {
                    networkManager.request(.askStoriesURL)
                }
                .listStyle(listStyle)
            } else {
                List {

                    ForEach(networkManager.askStoryIDs, id: \.self) { id in
                        Group {
                            if networkManager.askStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.askStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        ListElementView(networkManager.askStories[id]!)
                                    })
                                    .unredacted()
                            } else {
                                Text(networkManager.askStories.keys.contains(id) ? "\(networkManager.askStories[id]!.title)" : "ListElementPlaceholderText")
                                    .redacted(reason: .placeholder)
                            }
                        }
                            .onAppear {
                                networkManager.requestStory(id, cat: .ask)
                            }
                    }
                }
                .onAppear {
                    networkManager.request(.askStoriesURL)
                }
                .listStyle(listStyle)
            }
            
        case .show:
            if #available(iOS 15, *) {
                List {

                    ForEach(networkManager.showStoriesIDs, id: \.self) { id in
                        Group {
                            if networkManager.showStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.showStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        ListElementView(networkManager.showStories[id]!)
                                    })
                                    .unredacted()
                            } else {
                                Text(networkManager.showStories.keys.contains(id) ? "\(networkManager.showStories[id]!.title)" : "ListElementPlaceholderText")
                                    .redacted(reason: .placeholder)
                            }
                        }
                            .onAppear {
                                networkManager.requestStory(id, cat: .show)
                            }
                    }
                }
                .onAppear {
                    networkManager.request(.showStoriesURL)
                }
                .refreshable {
                    networkManager.request(.showStoriesURL)
                }
                .listStyle(listStyle)
            } else {
                List {

                    ForEach(networkManager.showStoriesIDs, id: \.self) { id in
                        Group {
                            if networkManager.showStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.showStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        ListElementView(networkManager.showStories[id]!)
                                    })
                                    .unredacted()
                            } else {
                                Text(networkManager.showStories.keys.contains(id) ? "\(networkManager.showStories[id]!.title)" : "ListElementPlaceholderText")
                                    .redacted(reason: .placeholder)
                            }
                        }
                            .onAppear {
                                networkManager.requestStory(id, cat: .show)
                            }
                    }
                }
                .onAppear {
                    networkManager.request(.showStoriesURL)
                }
                .listStyle(listStyle)
            }
            
        case .job:
            if #available(iOS 15, *) {
                List {

                    ForEach(networkManager.jobStoryIDs, id: \.self) { id in
                        Group {
                            if networkManager.jobStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.jobStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        ListElementView(networkManager.jobStories[id]!)
                                    })
                                    .unredacted()
                            } else {
                                Text(networkManager.jobStories.keys.contains(id) ? "\(networkManager.jobStories[id]!.title)" : "ListElementPlaceholderText")
                                    .redacted(reason: .placeholder)
                            }
                        }
                            .onAppear {
                                networkManager.requestStory(id, cat: .job)
                            }
                    }
                }
                .onAppear {
                    networkManager.request(.jobStoriesURL)
                }
                .refreshable {
                    networkManager.request(.jobStoriesURL)
                }
                .listStyle(listStyle)
            } else {
                List {

                    ForEach(networkManager.jobStoryIDs, id: \.self) { id in
                        Group {
                            if networkManager.jobStories.keys.contains(id) {
                                NavigationLink(
                                    destination: DetailView(networkManager.jobStories[id]!)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        ListElementView(networkManager.jobStories[id]!)
                                    })
                                    .unredacted()
                            } else {
                                Text(networkManager.jobStories.keys.contains(id) ? "\(networkManager.jobStories[id]!.title)" : "ListElementPlaceholderText")
                                    .redacted(reason: .placeholder)
                            }
                        }
                            .onAppear {
                                networkManager.requestStory(id, cat: .job)
                            }
                    }
                }
                .onAppear {
                    networkManager.request(.jobStoriesURL)
                }
                .listStyle(listStyle)
            }
            
        }
    }
}
