//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Roman on 27.09.21.
//

import Foundation

class NetworkManager: ObservableObject {
    
    // story property placeholder
    var placeholder: [Story] = []
    @Published var newStoryIDsPublished: [Int] = []
    
    // available properties
    @Published var stories: StoryList = StoryList(new: [])
    
    init() {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "testData", withExtension: "json") else { return }
        let data = (try? Data(contentsOf: url))!
        let story = try? decoder.decode(Story.self, from: data)
        self.placeholder = [story!]
    }
    
    func request() async {
        
        let newStories: [Story] = await requestNewStories()
        
        DispatchQueue.main.async { [self] in
            stories = StoryList(new: newStories)
        }
        
    }
    
    func requestNewStories() async -> [Story] {
        
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty")!
        let decoder = JSONDecoder()
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let newStoryIDs = try JSONSerialization.jsonObject(with: data, options: []) as? [Int] {
                
                DispatchQueue.main.async { [self] in
                    newStoryIDsPublished = newStoryIDs
                }
                
            }
        } catch {
            print("There has been an error.")
        }
        
        
        return placeholder
        
    }

}
