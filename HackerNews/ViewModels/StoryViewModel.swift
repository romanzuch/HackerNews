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
    
    // saved stories
    @Published var savedStories: [Story] = []
    
    // list limits
    @Published var newLimitHigh: Int = 20
    @Published var newLimitLow: Int = 0
    
    @Published var topLimitHigh: Int = 20
    @Published var topLimitLow: Int = 0
    
    @Published var bestLimitHigh: Int = 20
    @Published var bestLimitLow: Int = 0
    
    // story comments
    @Published var storyComments: [Comment] = []
    
    // MARK: - IDs
    
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
    
    func refreshStoryIDs(type: RequestType) {
        
        switch type {
        case .new:
            newStories = []
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
            topStories = []
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
            bestStories = []
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
    
    // MARK: - Story
    
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
                        if self.newStories.contains(story) {
                            return
                        } else {
                            self.newStories.append(story)
                        }
                    case .top:
                        if self.topStories.contains(story) {
                            return
                        } else {
                            self.topStories.append(story)
                        }
                    case .best:
                        if self.bestStories.contains(story) {
                            return
                        } else {
                            self.bestStories.append(story)
                        }
                    }
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
        
    }
    
    // MARK: - Saved stories
    
    func saveStory(_ story: Story) {
        if self.savedStories.contains(story) {
            print("Removing story from list.")
            let indexOfStory = self.savedStories.firstIndex(of: story)
            self.savedStories.remove(at: indexOfStory!)
        } else {
            self.savedStories.append(story)
        }
    }
    
    func removeStory(at offsets: IndexSet) {
        self.savedStories.remove(at: offsets.first!)
    }
    
    // MARK: - Comments
    
    func requestComments(commentIDs: [Int]) {
        
        if storyComments != nil {
            storyComments = []
        }
        
        let decoder: JSONDecoder = JSONDecoder()
        print("Requesting comments.")
        
        for id in commentIDs {
            
            let url: URL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let commentData = data, error == nil else { return }
                do {
                    let comment = try decoder.decode(Comment.self, from: commentData)
                    DispatchQueue.main.async {
                        debugPrint("Appending \(comment) to the list...")
                        self.storyComments.append(comment)
                    }
                } catch {
                    debugPrint("Decoding error: \(error)")
                }
                
            }.resume()
            
        }
        
    }
    
    // MARK: - Test Data Handling

    func getTestComment() -> Comment {
        let path = Bundle.main.path(forResource: "testComment", ofType: "json")
        var response: Comment?
        debugPrint(path as Any)
        let url = URL(fileURLWithPath: path!)
        debugPrint(url)
        do {
            let data = try Data(contentsOf: url)
            response = try JSONDecoder().decode(Comment.self, from: data)
            debugPrint(response as Any)
        } catch {
            debugPrint(error)
        }
        return response!
    }
    
}


