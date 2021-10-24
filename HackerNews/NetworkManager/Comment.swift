//
//  Comment.swift
//  HackerNews
//
//  Created by Roman on 17.10.21.
//

import Foundation

struct Comment: Hashable, Codable {
    
    var by: String?
    var id: Int
    var kids: [Int]?
    var parent: Int
    var text: String?
    var time: Int
    var type: String
    
    // deleted comments have an additional property
    // deleted, id, parent, time, type, ...
    var deleted: Bool?
    
    enum CodingKeys: CodingKey {
        
        case by, id, kids, parent, text, time, type
        case deleted
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.parent = try container.decode(Int.self, forKey: .parent)
        self.time = try container.decode(Int.self, forKey: .time)
        self.type = try container.decode(String.self, forKey: .type)
        
        self.kids = try container.decodeIfPresent([Int].self, forKey: .kids)
        self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.by = try container.decodeIfPresent(String.self, forKey: .by)
        
    }
    
}

enum CommentRequestError: Error {
    case badStatusCode
    case badComment(Error)
}

enum CommentUpdateMode {
    case append
    case complete
}
