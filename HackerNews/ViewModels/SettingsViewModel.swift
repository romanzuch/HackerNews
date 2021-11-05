//
//  SettingsViewModel.swift
//  HackerNews
//
//  Created by Roman on 28.10.21.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var appAppearance: appAppearanceMode = appAppearanceMode(rawValue: UserDefaults.standard.string(forKey: "appAppearance") ?? "System") ?? .system
    
    @Published var highlightColor: Color = Color(UserDefaults.standard.highlightColor ?? UIColor(.yellow))
//    @Published var highlightColor: Color = .yellow
    
    // MARK: - NOTIFICATIONS
    @Published var allowSubscription: Bool = UserDefaults.standard.bool(forKey: "allowSubscription")
    @Published var autoSubscription: Bool = UserDefaults.standard.bool(forKey: "autoSubscription")
    
    // MARK: - APP ICON
    @Published var appIcon: String = UserDefaults.standard.string(forKey: "appIcon") ?? "default"
    let appIcons: [String] = ["default", "light", "dark", "colorful"]
    
    
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
            switch UITraitCollection.current.userInterfaceStyle.self {
            case .light:
                return ColorScheme.light
            case .dark:
                return ColorScheme.dark
            case .unspecified:
                return ColorScheme.light
            @unknown default:
                fatalError()
            }
        }
    }
    
}


