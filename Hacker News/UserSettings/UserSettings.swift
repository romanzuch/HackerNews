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
    
    
    func saveStoryToDefaults(_ story: Story) {
        
        DispatchQueue.main.async { [self] in
            if savedStoryIDs.contains(story.id) {
                print("Already there.")
                self.removeStoryFromDefaults(story)
            } else {
                self.savedStoryIDs.append(story.id)
                self.defaults.set(savedStoryIDs, forKey: "savedStoryIDs")
            }
        }

    }
    
    func removeStoryFromDefaults(_ story: Story) {
        
        DispatchQueue.main.async { [self] in
            let storyIndex = self.savedStoryIDs.firstIndex(of: story.id)
            self.savedStoryIDs.remove(at: storyIndex!)
            self.defaults.set(savedStoryIDs, forKey: "savedStoryIDs")
        }
        
    }
}
