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
            Text("settings")
            .navigationBarTitle("settings")
        }
    }
}

struct SettingsHNMainView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHNMainView()
    }
}
