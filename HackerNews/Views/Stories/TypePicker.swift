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
                    .frame(width: UIScreen.main.bounds.width / 3 - 20)
                    .frame(height: 40)
                
                    .border(width: (selection == type) ? 5 : 0, edges: [.bottom], color: .yellow.opacity(0.35), padding: 0)
                    
                    .onTapGesture {
                        selection = type
                    }
            }
        }
        
    }
}
//
//struct TypePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        TypePicker(.constant(.new))
//    }
//}
