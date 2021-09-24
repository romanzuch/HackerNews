//
//  SelectionPill.swift
//  Hacker News
//
//  Created by Roman on 24.09.21.
//

import SwiftUI

struct SelectionPill: View {
    
    var cat: StoryCategory
    @Binding var selectedCategory: StoryCategory
    
    init(_ cat: StoryCategory, selection: Binding<StoryCategory>) {
        self.cat = cat
        self._selectedCategory = selection
    }
    
    var body: some View {
        Text(cat.rawValue)
            .font(.caption)
            .fontWeight(selectedCategory == cat ? .bold : .none)
            .foregroundColor(.white)
            .padding(8)
            .background(selectedCategory == cat ? Color(UIColor.systemBlue) : Color(UIColor.systemGray2))
            .cornerRadius(8)
            .padding()
            .onTapGesture {
                selectedCategory = cat
            }
    }
}
