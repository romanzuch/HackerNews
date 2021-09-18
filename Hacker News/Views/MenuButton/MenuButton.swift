//
//  MenuButton.swift
//  Hacker News
//
//  Created by Roman on 19.09.21.
//

import SwiftUI

struct MenuButton: View {
    
    @Binding var selectedCategory: StoryCategory
    
    init(_ cat: Binding<StoryCategory>) {
        self._selectedCategory = cat
    }
    
    var body: some View {
        Menu {
            
            Button(action: {
                selectedCategory = .new
            }, label: {
                if selectedCategory == .new {
                    Label("New", systemImage: "checkmark")
                } else {
                    Text("New")
                }
            })
            
            Button(action: {
                selectedCategory = .best
            }, label: {
                if selectedCategory == .best {
                    Label("Best", systemImage: "checkmark")
                } else {
                    Text("Best")
                }
            })
            
            Button(action: {
                selectedCategory = .top
            }, label: {
                if selectedCategory == .top {
                    Label("Top", systemImage: "checkmark")
                } else {
                    Text("Top")
                }
            })
            
        } label: {
            
            Image(systemName: "switch.2")
            
        }
    }
}
