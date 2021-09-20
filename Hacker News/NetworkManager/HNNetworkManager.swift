//
//  HNNetworkManager.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import Foundation

class HNNetworkManager: ObservableObject {
    
    // Story ID Arrays
    @Published var topStoryIDs: Array<Int> = []
    @Published var newStoryIDs: Array<Int> = []
    @Published var bestStoryIDs: Array<Int> = []
    
    // Story Arrays
    @Published var topStories: [Int:Story] = [:]
    @Published var newStories: [Int:Story] = [:]
    @Published var bestStories: [Int:Story] = [:]
    
    // Story Comments
    @Published var storyComments: [Int:Comment] = [:]
    
    func request(_ url: apiURL) {
        
        guard let urlRawValue = URL(string: url.rawValue) else { return }
        
        switch url {
        case .topStoriesURL:
            if topStoryIDs.count == 0 {
                requestIDs(urlRawValue, apiURL: url) { result in
                    switch result {
                    case .success:
                        print("top stories requested")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                return
            }
            
        case .newStoriesURL:
            if newStoryIDs.count == 0 {
                requestIDs(urlRawValue, apiURL: url) { result in
                    switch result {
                    case .success:
                        print("new stories requested")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                return
            }
            
        case .bestStoriesURL:
            if bestStoryIDs.count == 0 {
                requestIDs(urlRawValue, apiURL: url) { result in
                    switch result {
                    case .success:
                        print("best stories requested")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                return
            }
            
        }
        
    }
    
    private func requestIDs(_ url: URL, apiURL: apiURL, completionHandler: @escaping (Result<Bool, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(.badURL))
                return
            }
            var arr: Array<Int> = []
            
            do {
                if let json = try JSONSerialization.jsonObject( with: data, options: []) as? [Int] {
                    arr = json
                }
            } catch let error as NSError {
                print("Failed to serialize JSON: \(error.localizedDescription)")
            }
            
            switch apiURL {
            
            case .topStoriesURL:
                DispatchQueue.main.async {
                    self.topStoryIDs = arr
                    completionHandler(.success(true))
                }
            case .newStoriesURL:
                DispatchQueue.main.async {
                    self.newStoryIDs = arr
                    completionHandler(.success(true))
                }
            case .bestStoriesURL:
                DispatchQueue.main.async {
                    self.bestStoryIDs = arr
                    completionHandler(.success(true))
                }
                
            }
            
        }.resume()
        
    }
    
    func requestStory(_ id: Int, cat: StoryCategory) {
        
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty")!
        
        switch cat {
        case .new:
            if newStories.keys.contains(id) {
                return
            } else {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else { return }
                    let jsonDecoder = JSONDecoder()
                    if let story = try? jsonDecoder.decode(Story.self, from: data) {
                        DispatchQueue.main.async {
                            self.newStories[id] = story
                        }
                    }
                }.resume()
            }
            
        case .best:
            if bestStories.keys.contains(id) {
                return
            } else {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else { return }
                    let jsonDecoder = JSONDecoder()
                    if let story = try? jsonDecoder.decode(Story.self, from: data) {
                        DispatchQueue.main.async {
                            self.bestStories[id] = story
                        }
                    }
                }.resume()
            }
            
        case .top:
            if topStories.keys.contains(id) {
                return
            } else {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else { return }
                    let jsonDecoder = JSONDecoder()
                    if let story = try? jsonDecoder.decode(Story.self, from: data) {
                        DispatchQueue.main.async {
                            self.topStories[id] = story
                        }
                    }
                }.resume()
            }
            
        }
        
    }
    
    func requestComment(_ id: Int) {
        
        let url: URL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            if let comment = try? jsonDecoder.decode(Comment.self, from: data) {
                DispatchQueue.main.async {
                    self.storyComments[id] = comment
                }
            }
        }.resume()
        
    }
    
    func requestComments(_ ids: [Int]) {
        for id in ids {
            let url: URL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty")!
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                let jsonDecoder = JSONDecoder()
                if let comment = try? jsonDecoder.decode(Comment.self, from: data) {
                    DispatchQueue.main.async {
                        self.storyComments[id] = comment
                    }
                }
            }.resume()
        }
    }
    
    
}

enum apiURL: String {
    
    case topStoriesURL = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
    case newStoriesURL = "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty"
    case bestStoriesURL = "https://hacker-news.firebaseio.com/v0/beststories.json?print=pretty"
        
}
