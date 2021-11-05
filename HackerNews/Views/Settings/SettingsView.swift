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
                
                // MARK: - APPEARANCE AND COLOUR
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
                
                // MARK: - NOTIFICATIONS
                Section {
                    Toggle(isOn: .init(get: {
                        $viewModel.allowSubscription.wrappedValue
                    }, set: { value in
                        $viewModel.allowSubscription.wrappedValue = value
                        UserDefaults.standard.set(value, forKey: "allowSubscription")
                        switch value {
                        case true:
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    debugPrint("All set!")
                                } else if let error = error {
                                    debugPrint(error.localizedDescription)
                                } else {
                                    debugPrint("NO")
                                    DispatchQueue.main.async {
                                        $viewModel.allowSubscription.wrappedValue = false
                                    }
                                }
                            }
                        case false:
                            $viewModel.autoSubscription.wrappedValue = value
                            UserDefaults.standard.set(value, forKey: "autoSubscription")
                        }
                    })) {
                        Label {
                            Text("Get story notifications")
                        } icon: {
                            Image(systemName: "bell.badge.fill")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .padding(6.0)
                                .background {
                                    Color.red
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                        }

                    }
                    Toggle(isOn: $viewModel.autoSubscription) {
                        Label {
                            Text("Auto story notifications")
                        } icon: {
                            Image(systemName: "bell.and.waveform.fill")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .padding(6.0)
                                .background {
                                    Color.green
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                        }
                    }
                        .disabled(!viewModel.allowSubscription)
                } header: {
                    Text("Notifications")
                }
                
                // MARK: - APP ICON
                Picker(selection: $viewModel.appIcon) {
                    ForEach(viewModel.appIcons, id: \.self) { icon in
                        Text(icon)
                    }
                } label: {
                    Text("App Icon")
                }
                .onReceive([self.$viewModel.appIcon].publisher.first()) { value in
                    //UserDefaults.standard.set(value, forKey: "appAppearance")
                    UserDefaults.standard.set(value.wrappedValue, forKey: "appIcon")
                }



            }
            .navigationTitle("Settings")
        }
    }
}
