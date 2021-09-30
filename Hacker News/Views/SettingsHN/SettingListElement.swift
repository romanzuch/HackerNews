//
//  SettingListElement.swift
//  Hacker News
//
//  Created by Roman on 25.09.21.
//

import SwiftUI

struct SettingListElement: View {
    
    var icon: String
    var title: String
    var setting: String
    
    var body: some View {
        Label {
            HStack {
                Text(title)
                Spacer()
                Text(setting)
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.systemGray3))
            }
        } icon: {
            Image(systemName: icon)
        }
    }
}
