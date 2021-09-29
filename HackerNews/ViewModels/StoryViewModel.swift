//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import Foundation

class StoryViewModel: ObservableObject {
    
    @Published var newStories: [Story] = []
    @Published var newStoryIds: [Int] = []
    
    init() {
        requestNewStoryIDs()
    }
    
    func requestNewStoryIDs() {
        
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                if let newStoryIds = try JSONSerialization.jsonObject(with: data, options: []) as? [Int] {
                    for id in newStoryIds {
                        self.requestStory(id: id)
                    }
                }
            } catch {
                print("JSONSerialization error:", error)
            }
        }.resume()
        
    }
    
    func requestStory(id storyID: Int) {
        
        let decoder = JSONDecoder()
        let storyURL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyID).json?print=pretty")!
        
        URLSession.shared.dataTask(with: storyURL) { (data, response, error) in
            guard let storyData = data, error == nil else { return }
            do {
                let story = try decoder.decode(Story.self, from: storyData)
                DispatchQueue.main.async {
                    print("Appending \(story) \n")
                    self.newStories.append(story)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
        
    }
    
}
