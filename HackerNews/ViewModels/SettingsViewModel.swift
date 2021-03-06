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
    //@Published var appIcon: String = UserDefaults.standard.string(forKey: "appIcon") ?? "default"
    @Published var currentIndex: Int = UserDefaults.standard.integer(forKey: "currentIndex")
    var iconNames: [String] = ["Standard", "Light", "Dark", "Colorful"]
    
    
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
    
    func setAppIcon(value pickerValue: Int) {
        
        debugPrint(pickerValue)
        UserDefaults.standard.set(pickerValue, forKey: "currentIndex")
        
        let alternateIconName = UIApplication.shared.alternateIconName
        
        debugPrint(alternateIconName)
        
        if alternateIconName == nil && pickerValue == 0 {
            UserDefaults.standard.set(0, forKey: "currentIndex")
        } else {
            if self.iconNames[pickerValue] != alternateIconName {
                UIApplication.shared.setAlternateIconName(self.iconNames[pickerValue]) { error in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                    } else {
                        debugPrint("Success!")
                    }
                }
            }
        }
    }
    
}


