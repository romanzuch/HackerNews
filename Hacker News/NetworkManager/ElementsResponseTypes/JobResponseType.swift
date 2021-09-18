//
//  JobResponseType.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import Foundation

struct Job: Codable {
    
    var user: String
    var id: Int
    var score: Int
    var text: String
    var time: Int
    var title: String
    var type: String
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        
        case user = "by"
        case id, score, text, time, title, type, url
        
    }
    
}
