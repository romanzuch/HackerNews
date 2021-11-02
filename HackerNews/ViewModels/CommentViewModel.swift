//
//  CommentViewModel.swift
//  HackerNews
//
//  Created by Roman on 02.11.21.
//

import Foundation
import SwiftUI

class CommentViewModel: ObservableObject {
    
    func getCommentMarkerColor(commentLevel: Int, settingsViewModel: SettingsViewModel) -> Color {
        switch commentLevel {
        case 0:
            return settingsViewModel.highlightColor.opacity(0)
        default:
            return settingsViewModel.highlightColor.opacity(Double(1/Double(commentLevel)))
        }
    }
    
}
