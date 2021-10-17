//
//  Comment.swift
//  HackerNews
//
//  Created by Roman on 17.10.21.
//

import Foundation

struct Comment: Hashable, Codable {
    
    var by: String
    var id: Int
    var kids: [Int]?
    var parent: Int
    var text: String
    var time: Int
    var type: String
    
    enum CodingKeys: CodingKey {
        
        case by, id, kids, parent, text, time, type
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.by = try container.decode(String.self, forKey: .by)
        self.id = try container.decode(Int.self, forKey: .id)
        self.parent = try container.decode(Int.self, forKey: .kids)
        self.time = try container.decode(Int.self, forKey: .time)
        self.text = try container.decode(String.self, forKey: .text)
        self.type = try container.decode(String.self, forKey: .type)
        
        self.kids = try container.decodeIfPresent([Int].self, forKey: .kids)
        
    }
    
}
