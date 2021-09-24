//
//  CommentResponseType.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import Foundation

struct Comment: Codable {
    
    var user: String
    var id: Int
    var comments: [Int]
    var parent: Int
    var text: String
    var time: Int
    var type: String
    
    enum CodingKeys: String, CodingKey {
        
        case user = "by"
        case comments = "kids"
        case id, parent, text, time, type
        
    }
    
}
