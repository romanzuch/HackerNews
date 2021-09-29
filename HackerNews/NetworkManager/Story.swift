//
//  Story.swift
//  HackerNews
//
//  Created by Roman on 27.09.21.
//

import Foundation

struct Story: Codable, Hashable {
    
    var by: String
    var descendants: Int
    var id: Int
    var kids: [Int]
    var score: Int
    var time: Int
    var title: String
    var type: String
    var url: String
    
}

