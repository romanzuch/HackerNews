//
//  ReloadButton.swift
//  HackerNews
//
//  Created by Roman on 30.09.21.
//

import SwiftUI

struct ReloadButton: View {
    
    var storyVM: StoryViewModel
    var type: RequestType
    
    init(viewModel: StoryViewModel, type: RequestType) {
        self.storyVM = viewModel
        self.type = type
    }
    
    var body: some View {
        Group {
            if storyVM.newLimitHigh < 500 {
                EmptyView()
            } else {
                Button(action: {
                    storyVM.newLimitHigh = storyVM.newLimitHigh + 20
                    storyVM.newLimitLow = storyVM.newLimitLow + 20
                }, label: {
                    
                })
            }
        }
    }
}
