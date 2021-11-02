//
//  SettingsView.swift
//  HackerNews
//
//  Created by Roman on 28.10.21.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("Appearance", selection: $viewModel.appAppearance) {
                        ForEach(SettingsViewModel.appAppearanceMode.allCases, id: \.self) { scheme in
                            Text(scheme.rawValue)
                        }
                    }
                    .onReceive([self.$viewModel.appAppearance].publisher.first()) { value in
                        //UserDefaults.standard.set(value, forKey: "appAppearance")
                        switch value.wrappedValue {
                            
                        case .dark:
                            UserDefaults.standard.set(SettingsViewModel.appAppearanceMode.dark.rawValue, forKey: "appAppearance")
                        case .light:
                            UserDefaults.standard.set(SettingsViewModel.appAppearanceMode.light.rawValue, forKey: "appAppearance")
                        case .system:
                            UserDefaults.standard.set(SettingsViewModel.appAppearanceMode.system.rawValue, forKey: "appAppearance")
                        
                        }
                    }
                    ColorPicker("Highlight colour", selection: $viewModel.highlightColor)
                        .onReceive([self.$viewModel.highlightColor].publisher.first()) { value in
                            UserDefaults.standard.highlightColor = UIColor(value.wrappedValue)
                        }
                } header: {
                    Text("Appearance")
                }

            }
            .navigationTitle("Settings")
        }
    }
}
