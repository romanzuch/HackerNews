//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import Foundation
import Combine

class StoryViewModel: ObservableObject {
    
    // stories
    @Published var newStories: [Story] = []
    @Published var topStories: [Story] = []
    @Published var bestStories: [Story] = []
    
    // list limits
    @Published var newLimitHigh: Int = 20
    @Published var newLimitLow: Int = 0
    
    @Published var topLimitHigh: Int = 20
    @Published var topLimitLow: Int = 0
    
    @Published var bestLimitHigh: Int = 20
    @Published var bestLimitLow: Int = 0
    
    func requestStoryIDs(type: RequestType) {
        
        switch type {
        case .new:
            let url = URL(string: "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty")!
            
            if newStories.count != newLimitHigh {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data, error == nil else { return }
                    do {
                        if let newStoryIds = try JSONSerialization.jsonObject(with: data, options: []) as? [Int] {
                            for id in newStoryIds[self.newLimitLow..<self.newLimitHigh] {
                                self.requestStory(id: id, type: .new)
                            }
                        }
                    } catch {
                        print("JSONSerialization error:", error)
                    }
                }.resume()
            } else { return }
            
        case .top:
            let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")!
            
            if topStories.count != topLimitHigh {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data, error == nil else { return }
                    do {
                        if let topStoryIds = try JSONSerialization.jsonObject(with: data, options: []) as? [Int] {
                            for id in topStoryIds[self.topLimitLow..<self.topLimitHigh] {
                                self.requestStory(id: id, type: .top)
                            }
                        }
                    } catch {
                        print("JSONSerialization error:", error)
                    }
                }.resume()
            } else { return }
            
        case .best:
            let url = URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json?print=pretty")!
            
            if bestStories.count != bestLimitHigh {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data, error == nil else { return }
                    do {
                        if let bestStoryIds = try JSONSerialization.jsonObject(with: data, options: []) as? [Int] {
                            for id in bestStoryIds[self.bestLimitLow..<self.bestLimitHigh] {
                                self.requestStory(id: id, type: .best)
                            }
                        }
                    } catch {
                        print("JSONSerialization error:", error)
                    }
                }.resume()
            } else { return }
            
        }
        
    }
    
    func requestStory(id storyID: Int, type: RequestType) {
        
        let decoder = JSONDecoder()
        let storyURL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyID).json?print=pretty")!
        
        URLSession.shared.dataTask(with: storyURL) { (data, response, error) in
            guard let storyData = data, error == nil else { return }
            do {
                let story = try decoder.decode(Story.self, from: storyData)
                DispatchQueue.main.async {
                    switch type {
                    case .new:
                        self.newStories.append(story)
                    case .top:
                        self.topStories.append(story)
                    case .best:
                        self.bestStories.append(story)
                    }
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
        
    }
    
}
