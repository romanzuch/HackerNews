//
//  StoryDecoder.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import Foundation

struct Story: Codable {
    
    var user: String
    var id: Int
    var comments: [Int]?
    var score: Int
    var time: Int
    var title: String
    var type: String
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        
        case user = "by"
        case comments = "kids"
        case id, score, time, title, type, url
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(String.self, forKey: .user)
        self.id = try container.decode(Int.self, forKey: .id)
        self.comments = try container.decodeIfPresent([Int].self, forKey: .comments)
        self.score = try container.decode(Int.self, forKey: .score)
        self.time = try container.decode(Int.self, forKey: .time)
        self.title = try container.decode(String.self, forKey: .title)
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        
    }
    
}
