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
    var comments: [Int]
    var score: Int
    var time: Int
    var title: String
    var type: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        
        case user = "by"
        case comments = "kids"
        case id, score, time, title, type, url
        
    }
    
}
