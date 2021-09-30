//
//  PollResponseType.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import Foundation

struct Poll: Codable {
    
    var user: String
    var id: Int
    var comments: [Int]
    var pollOptions: [Int]
    var score: Int
    var text: String
    var time: Int
    var title: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        
        case user = "by"
        case comments = "kids"
        case pollOptions = "parts"
        case id, score, text, time, title, type
        
    }
}

struct PollOption: Codable {
    
    var user: String
    var id: Int
    var poll: Int
    var score: Int
    var text: String
    var time: Int
    var type: String
    
    enum CodingKeys: String, CodingKey {
        
        case user = "by"
        case id, poll, score, text, time, type
        
    }
    
}
