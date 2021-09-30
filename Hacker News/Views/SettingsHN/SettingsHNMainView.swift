//
//  SettingsHNMainView.swift
//  Hacker News
//
//  Created by Roman on 18.09.21.
//

import SwiftUI

struct SettingsHNMainView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("App settings")) {
                        NavigationLink(
                            destination: Text("Setting View"),
                            label: {
                                SettingListElement(icon: "globe", title: "Browser", setting: userSettings.browserSetting.rawValue)
                            }
                        )
                    }
                }
                .listStyle(InsetListStyle())
                Spacer()
                Signature()
            }
            .navigationBarTitle("settings")
        }
    }
}

struct SettingsHNMainView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHNMainView()
    }
}
