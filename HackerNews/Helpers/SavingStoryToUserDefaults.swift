//
//  SavingStoryToUserDefaults.swift
//  HackerNews
//
//  Created by Roman on 02.11.21.
//

import Foundation

extension UserDefaults {
    
    func set(_ stories: [Story]?, forKey defaultName: String) {
        let encoder = JSONEncoder()
        var encodedStories: [Data] = []
        for story in stories! {
            do {
                let data = try encoder.encode(story)
                encodedStories.append(data)
            } catch {
                debugPrint(error.localizedDescription)
                removeObject(forKey: defaultName)
            }
        }
        set(encodedStories, forKey: defaultName)
    }
    
    func stories(forKey defaultName: String) -> [Story]? {
        let decoder = JSONDecoder()
        var decodedStories: [Story] = []
        for dataElement in (array(forKey: defaultName) ?? []).self as! [Data] {
            do {
                let story = try decoder.decode(Story.self, from: dataElement)
                decodedStories.append(story)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return decodedStories
    }
    
}

extension UserDefaults {
    var savedStories: [Story]? {
        get { stories(forKey: "savedStories") }
        set { set(newValue, forKey: "savedStories") }
    }
}
