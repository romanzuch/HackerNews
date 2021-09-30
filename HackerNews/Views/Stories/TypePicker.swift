//
//  TypePicker.swift
//  HackerNews
//
//  Created by Roman on 30.09.21.
//

import SwiftUI

struct TypePicker: View {
    
    @Binding var selection: RequestType
    
    init(_ selection: Binding<RequestType>) {
        self._selection = selection
    }
    
    var body: some View {
        
        HStack {
            ForEach(RequestType.allCases, id: \.self) { type in
                Text("\(type.rawValue)")
                    .fontWeight(selection == type ? .bold : .none)
                    .onTapGesture {
                        selection = type
                    }
            }
        }
        
    }
}
