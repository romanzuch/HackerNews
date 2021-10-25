//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Roman on 29.09.21.
//

import Foundation
import Combine
import SwiftUI

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
    @Published var storyComments: [Int:[Comment]] = [:]
    
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
    
    func requestComment(id: Int) async throws -> Comment {
        let requestURL: URL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty")!
        let requestDecoder: JSONDecoder = JSONDecoder()
        
        let request = URLRequest(url: requestURL)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw CommentRequestError.badStatusCode
        }
        
        do {
            return try requestDecoder.decode(Comment.self, from: data)
        } catch {
            throw CommentRequestError.badComment(error)
        }
    }
    
    func updateStoryComments(id: Int, comment: Comment, mode: CommentUpdateMode) {
        switch mode {
        case .append:
            DispatchQueue.main.async { [self] in
                storyComments[id]?.append(comment)
            }
        case .complete:
            DispatchQueue.main.async { [self] in
                storyComments[id] = [comment]
            }
        }
    }
    
    func requestComments(commentIDs: [Int]) {
        
        if storyComments != nil {
            DispatchQueue.main.async { [self] in
                storyComments = [:]
            }
        }
        
        debugPrint(commentIDs[0])
        
        Task.init() {
            
            var commentList: [Int] = commentIDs
            var kidsCount: Int = 0
            
            while !commentList.isEmpty {
                do {
                    let comment = try await requestComment(id: commentList[0])
                    if (comment.kids != nil) {
                        kidsCount += comment.kids?.count ?? 0
                        for kid in comment.kids! {
                            commentList.append(kid)
                        }
                    }
                    
                    // check if key (comment id) is already present
                    if (storyComments[comment.parent] != nil) {
                        updateStoryComments(id: comment.parent, comment: comment, mode: .append)
                        commentList.remove(at: 0)
                    } else {
                        updateStoryComments(id: comment.parent, comment: comment, mode: .complete)
                        commentList.remove(at: 0)
                    }
                    
                } catch {
                    debugPrint(error)
                }
            }
            
        }
        
    }
    
    func getCommentMarkerColor(commentLevel: Int) -> Color {
        switch commentLevel {
        case 0:
            return Color.yellow.opacity(0)
        default:
            return Color.yellow.opacity(Double(1/Double(commentLevel)))
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


