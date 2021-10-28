//
//  SettingsViewModel.swift
//  HackerNews
//
//  Created by Roman on 28.10.21.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var appAppearance: appAppearanceMode = .system
    @Environment(\.colorScheme) var colorScheme
    
    enum appAppearanceMode: String, CaseIterable {
        case dark = "Dark"
        case light = "Light"
        case system = "System"
    }
    
    func getAppAppearance() -> ColorScheme {
        switch self.appAppearance {
        case .light:
            return ColorScheme.light
        case .dark:
            return ColorScheme.dark
        case .system:
            return self.colorScheme
        }
    }
    
}


