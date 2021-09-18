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
    @Published var topStories: Array<Story> = []
    @Published var newStories: Array<Story> = []
    @Published var bestStories: Array<Story> = []
    
    // Story Dummies
    let topStoriesDummy: Array<Story> = [
        Story(user: "jcubic", id: 28577371, comments: [28578546, 28578424, 28577860], score: 144, time: 1631982344, title: "How to Rapidly Improve at Any Programming Language (2016)", type: "story", url:  "https://www.cbui.dev/how-to-rapidly-improve-at-any-programming-language/"),
        Story(user: "jcubic", id: 28577371, comments: [28578546, 28578424, 28577860], score: 144, time: 1631982344, title: "How to Rapidly Improve at Any Programming Language (2016)", type: "story", url:  "https://www.cbui.dev/how-to-rapidly-improve-at-any-programming-language/")
    ]
    
    func request(_ url: apiURL) {
        
        guard let urlRawValue = URL(string: url.rawValue) else { return }
        
        switch url {
        case .topStoriesURL:
            if topStoryIDs.count == 0 {
                requestIDs(urlRawValue, apiURL: url) { [self] result in
                    switch result {
                    case .success:
                        print("success")
                        requestStories(topStoryIDs)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                return
            }
            
        case .newStoriesURL:
            if newStoryIDs.count == 0 {
                requestIDs(urlRawValue, apiURL: url) { [self] result in
                    switch result {
                    case .success:
                        print("success")
                        requestStories(newStoryIDs)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                return
            }
            
        case .bestStoriesURL:
            if bestStoryIDs.count == 0 {
                requestIDs(urlRawValue, apiURL: url) { [self] result in
                    switch result {
                    case .success:
                        print("success")
                        requestStories(bestStoryIDs)
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
            
            print("data: \(data)")
            
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
    
    private func requestStories(_ IDs: Array<Int>) {
        for id in IDs {
            print(id)
        }
    }
    
    
}

enum apiURL: String {
    
    case topStoriesURL = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
    case newStoriesURL = "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty"
    case bestStoriesURL = "https://hacker-news.firebaseio.com/v0/beststories.json?print=pretty"
        
}
