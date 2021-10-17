//
//  StoriesListView.swift
//  HackerNews
//
//  Created by Roman on 30.09.21.
//

import SwiftUI

struct StoriesListView: View {
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    var selection: RequestType
    @State private var showDetails: Bool = false
    @Environment(\.openURL) var openURL
    
    // search bindings
    @State private var searchTextNew: String = ""
    @State private var searchTextTop: String = ""
    @State private var searchTextBest: String = ""
    
    init(selection: RequestType) {
        self.selection = selection
    }
    
    var body: some View {
        
        switch selection {
        case .new:
            VStack {
                List {
                    ForEach(storyViewModel.newStories.filter{($0.title.range(of: searchTextNew, options: .caseInsensitive) != nil) || searchTextNew == ""}, id: \.self.hashValue) { story in
                        NavigationLink(destination: {
                            StoryDetailView(story: story)
                        }, label: {
                            StoryRowView(story: story)
                        })
                        
                            .swipeActions(edge: .leading) {
                                
                                Button {
                                    storyViewModel.saveStory(story)
                                } label: {
                                    if storyViewModel.savedStories.contains(story) {
                                        Label("Remove", systemImage: "star.slash.fill")
                                    } else {
                                        Label("Save", systemImage: "star.fill")
                                    }
                                }
                                .tint((storyViewModel.savedStories.contains(story)) ? .red : .green)
                                
                                Button {
                                    ShareViewController().share(story.title, urlString: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")
                                } label: {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                
                            }
                            .swipeActions(edge: .trailing) {
                                
                                Button {
                                    openURL(URL(string: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")!)
                                } label: {
                                    Label("Browse", systemImage: "globe")
                                }
                                .tint(.yellow.opacity(0.35))
                                
                            }
                    }
                }
                .onAppear {
                    storyViewModel.requestStoryIDs(type: .new)
                }
                .searchable(text: $searchTextNew)
                .refreshable {
                    storyViewModel.refreshStoryIDs(type: .new)
                }
            }
            
        case .top:
            VStack {
                List {
                    ForEach(storyViewModel.topStories.filter{($0.title.range(of: searchTextTop, options: .caseInsensitive) != nil) || searchTextTop == ""}, id: \.self.hashValue) { story in
                        NavigationLink(destination: {
                            StoryDetailView(story: story)
                        }, label: {
                            StoryRowView(story: story)
                        })
                        
                            .swipeActions(edge: .leading) {
                                
                                Button {
                                    storyViewModel.saveStory(story)
                                } label: {
                                    if storyViewModel.savedStories.contains(story) {
                                        Label("Remove", systemImage: "star.slash.fill")
                                    } else {
                                        Label("Save", systemImage: "star.fill")
                                    }
                                }
                                .tint((storyViewModel.savedStories.contains(story)) ? .red : .green)
                                
                                Button {
                                    ShareViewController().share(story.title, urlString: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")
                                } label: {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                
                            }
                            .swipeActions(edge: .trailing) {
                                
                                Button {
                                    openURL(URL(string: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")!)
                                } label: {
                                    Label("Browse", systemImage: "globe")
                                }
                                .tint(.yellow.opacity(0.35))
                                
                            }
                        
                    }
                }
                .onAppear {
                    storyViewModel.requestStoryIDs(type: .top)
                }
                .searchable(text: $searchTextTop)
                .refreshable {
                    storyViewModel.refreshStoryIDs(type: .top)
                }
                
            }
            
        case .best:
            VStack {
                List {
                    ForEach(storyViewModel.bestStories.filter{($0.title.range(of: searchTextBest, options: .caseInsensitive) != nil) || searchTextBest == ""}, id: \.self.hashValue) { story in
                        NavigationLink(destination: {
                            StoryDetailView(story: story)
                        }, label: {
                            StoryRowView(story: story)
                        })
                        
                            .swipeActions(edge: .leading) {
                                
                                Button {
                                    storyViewModel.saveStory(story)
                                } label: {
                                    if storyViewModel.savedStories.contains(story) {
                                        Label("Remove", systemImage: "star.slash.fill")
                                    } else {
                                        Label("Save", systemImage: "star.fill")
                                    }
                                }
                                .tint((storyViewModel.savedStories.contains(story)) ? .red : .green)
                                
                                Button {
                                    ShareViewController().share(story.title, urlString: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")
                                } label: {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                
                            }
                            .swipeActions(edge: .trailing) {
                                
                                Button {
                                    openURL(URL(string: story.url ?? "https://news.ycombinator.com/item?id=\(story.id)")!)
                                } label: {
                                    Label("Browse", systemImage: "globe")
                                }
                                .tint(.yellow.opacity(0.35))
                                
                            }
                        
                    }
                }
                .onAppear {
                    storyViewModel.requestStoryIDs(type: .best)
                }
                .searchable(text: $searchTextBest)
                .refreshable {
                    storyViewModel.refreshStoryIDs(type: .best)
                }
                
            }
            
        }
        
    }
}
