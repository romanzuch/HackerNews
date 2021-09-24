//
//  SelectionPickerView.swift
//  Hacker News
//
//  Created by Roman on 24.09.21.
//

import SwiftUI

struct SelectionPickerView: View {
    
    @Binding var selectedCategory: StoryCategory
    
    init(_ cat: Binding<StoryCategory>) {
        self._selectedCategory = cat
    }
    
    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(StoryCategory.allCases, id: \.self) { cat in
                    SelectionPill(cat, selection: $selectedCategory)
                }
            }
        }
        
    }
}
