//
//  SubscriptionAlert.swift
//  HackerNews
//
//  Created by Roman on 04.11.21.
//

import SwiftUI

struct AlertController {
    
    var settingsViewModel: SettingsViewModel
    var storyViewModel: StoryViewModel
    
    init(settingsViewModel: SettingsViewModel, storyViewModel: StoryViewModel) {
        self.settingsViewModel = settingsViewModel
        self.storyViewModel = storyViewModel
    }
    
    func subscriptionAlert(story: Story) -> Alert {
        return Alert(title: Text("Receive notifications?"), message: Text("Do you want to receive notifications for this story? \(story.by)"), primaryButton: .default(Text("Yes"), action: {
            self.storyViewModel.subscribeToStory(story: story)
        }), secondaryButton: .cancel(Text("No")))
    }
    
    
    
}

