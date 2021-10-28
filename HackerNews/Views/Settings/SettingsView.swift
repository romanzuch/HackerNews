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
                    NavigationLink("Colours") {
                        ColourSettingView()
                    }
                } header: {
                    Text("Appearance")
                }

            }
            .navigationTitle("Settings")
        }
    }
}
