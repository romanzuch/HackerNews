//
//  Story.swift
//  HackerNews
//
//  Created by Roman on 27.09.21.
//

import Foundation

struct Story: Codable, Hashable {
    
    var by: String
    var descendants: Int?
    var id: Int
    var kids: [Int]?
    var score: Int
    var time: Int
    var title: String
    var type: String
    var url: String?
    
    enum CodingKeys: CodingKey {
        
        case by, descendants, id, kids, score, time, title, type, url
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.by = try container.decode(String.self, forKey: .by)
        self.id = try container.decode(Int.self, forKey: .id)
        self.score = try container.decode(Int.self, forKey: .score)
        self.time = try container.decode(Int.self, forKey: .time)
        self.title = try container.decode(String.self, forKey: .title)
        self.type = try container.decode(String.self, forKey: .type)
        
        self.descendants = try container.decodeIfPresent(Int.self, forKey: .descendants)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        
    }
    
}

