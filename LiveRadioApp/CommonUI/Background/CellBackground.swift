//
//  CellBackground.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 12.12.2024.
//

import SwiftUI

struct CellBackground<Content: View>: View {
    var isSelected: Bool
    let content: Content

    init(isSelected: Bool, @ViewBuilder content: () -> Content) {
        self.isSelected = isSelected
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
                .foregroundColor(isSelected ? .clear : .white)
                .opacity(isSelected ? 0 : 0.2)
                .background(isSelected ? Color.eclipse8 : Color.mainBg)
            content
        }
        .cornerRadius(15)
    }
}

