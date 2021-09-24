//
//  SavedStoryType.swift
//  Hacker News
//
//  Created by Roman on 24.09.21.
//

import Foundation

struct SavedStory: Codable, Hashable {
    var time: Date
    var story: Story
}
