//
//  UserSettings.swift
//  Hacker News
//
//  Created by Roman on 23.09.21.
//

import Foundation

class UserSettings: ObservableObject {
    
    var defaults: UserDefaults = UserDefaults.standard
    
    @Published var savedStoryIDs: Array<Int> = []
    @Published var savedStories: [Data] = []
    
    init() {
        self.savedStories = self.defaults.object(forKey: "savedStories") as? [Data] ?? [Data]()
        self.savedStoryIDs = self.defaults.object(forKey: "savedStoryIDs") as? [Int] ?? [Int]()
    }
    
    
    func saveStoryToDefaults(_ story: Story, time: Date) {
        
        DispatchQueue.main.async { [self] in
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            

            if savedStoryIDs.contains(story.id) {
                removeStoryFromDefaults(story)
            } else {
                let storyToSave = SavedStory(time: time, story: story)
                do {
                    print("Saving story.")
                    let data = try encoder.encode(storyToSave)
                    savedStoryIDs.append(story.id)
                    savedStories.append(data)
                    defaults.set(savedStories, forKey: "savedStories")
                    defaults.set(savedStoryIDs, forKey: "savedStoryIDs")
                } catch {
                    print("Unable to encode story...")
                }
            }
            
        }

    }
    
    func removeStoryFromDefaults(_ story: Story) {
        
        DispatchQueue.main.async { [self] in
            let decoder = JSONDecoder()
            
            for (index, data) in savedStories.enumerated() {
                do {
                    if try decoder.decode(SavedStory.self, from: data).story.id == story.id {
                        savedStories.remove(at: index)
                        defaults.set(savedStories, forKey: "savedStories")
                    }
                } catch {
                    print("Unable to decode story data...")
                }
            }
            let indexOfID = savedStoryIDs.firstIndex(of: story.id)
            savedStoryIDs.remove(at: indexOfID!)
            defaults.set(savedStoryIDs, forKey: "savedStoryIDs")
            
        }
        
    }
}
