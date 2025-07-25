//
//  SearchBarView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 26.05.2025.
//

import SwiftUI

struct SearchBarView: View {
    
    private enum Drawing {
        static let textFieldPlaceHolder = "Search radio station"
    }
    
    @Binding var searchText: String 
    
    var body: some View {
        HStack {
            Image(.search)
            TextField("", text: $searchText)
                .placeholder(when: searchText.isEmpty, placeholder: {
                    Text( Drawing.textFieldPlaceHolder).foregroundStyle(.white)
                })
                .foregroundColor(.white)
            ZStack {
                Image(.textFieldButton)
                Image(.leftArrow)
            }
        }
        .foregroundColor(.white)
        .applyFonts(for: .textField)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.textField)
        )
        .padding()
        
        
        
    }
}

#Preview {
    ZStack {
        Color.mainBg
        SearchBarView(searchText: .constant(""))
    }
}
