//
//  NewStoriesHNView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct NewStoriesHNView: View {
    
    @EnvironmentObject var networkManager: HNNetworkManager
    
    var body: some View {
        List {
//            ForEach(Array(networkManager.topStoriesDummy.enumerated()), id: \.offset) { index, story in
//                NavigationLink(
//                    destination:
//                        DetailView(story)
//                    ,
//                    label: {
//                        ListElementView(story)
//                    })
//                    .onAppear {
//                        print("\(index) appearing.")
//                    }
//            }
            ForEach(networkManager.newStoryIDs, id: \.self) { id in
                Group {
                    if networkManager.newStories.keys.contains(id) {
                        NavigationLink(
                            destination: DetailView(networkManager.newStories[id]!),
                            label: {
                                ListElementView(networkManager.newStories[id]!)
//                                Text(networkManager.newStories.keys.contains(id) ? "\(networkManager.newStories[id]!.title)" : "ListElementPlaceholderText")
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
        .listStyle(GroupedListStyle())
        .onAppear {
            networkManager.request(.newStoriesURL)
        }
    }
    
}

