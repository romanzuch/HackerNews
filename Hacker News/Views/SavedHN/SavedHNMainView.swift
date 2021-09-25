//
//  SavedHNMainView.swift
//  Hacker News
//
//  Created by Roman on 23.09.21.
//

import SwiftUI

struct SavedHNMainView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var networkManager: HNNetworkManager
    let savedStoryData: Array<Data>
    let savedStories: Array<SavedStory>
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init(_ userSettings: UserSettings) {
        let decoder = JSONDecoder()
        let userDefaultStories = userSettings.defaults.object(forKey: "savedStories") as? [Data] ?? [Data]()
        self.savedStoryData = userDefaultStories
        var savedStories = [SavedStory]()
        for (storyData) in userDefaultStories {
            do {
                let story = try decoder.decode(SavedStory.self, from: storyData)
                savedStories.append(story)
            } catch {
                print("SavedHNMainView: Unable to decode story data.")
            }
        }
        self.savedStories = savedStories
    }
    
    var body: some View {
        NavigationView {
            Group {
                if (savedStoryData.count != 0) {

                    if #available(iOS 15, *) {
                        List {
                            ForEach(self.savedStories, id: \.self) { story in
                                NavigationLink(
                                    destination: DetailView(story.story)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        SavedListElementView(story)
                                })
                            }
//                            .onDelete(perform: delete)
                        }
//                        .toolbar {
//                            EditButton()
//                        }
//                        .refreshable {
//                            print("Refresh")
//                        }
                        .listStyle(InsetListStyle())
                    } else {
                        List {
                            ForEach(self.savedStories, id: \.self) { story in
                                NavigationLink(
                                    destination: DetailView(story.story)
                                        .environmentObject(networkManager)
                                        .environmentObject(userSettings)
                                    ,
                                    label: {
                                        SavedListElementView(story)
                                })
                            }
//                            .onDelete(perform: delete)
                        }
//                        .toolbar {
//                            EditButton()
//                        }
                        .listStyle(InsetListStyle())
                    }
                    
                } else {
                    
                    Text("No stories saved.")
                    
                }
                
            }
            .navigationBarTitle("saved")
        }
    }
    
    func delete(at offsets: IndexSet) {
        DispatchQueue.main.async {
            let index = offsets[offsets.startIndex]
            print(index)
//            let story = userSettings.savedStoryIDs[index]
//            userSettings.removeStoryFromDefaults(id)
        }
    }
    
}
