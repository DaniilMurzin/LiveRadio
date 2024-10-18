//
//  TabBarBackground.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 16.10.2024.
//

import SwiftUI

struct TabBarBackground<V: View>: View {
    
    let content: () -> V
    
    init(@ViewBuilder content: @escaping () -> V) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Color(.mainBg)
                .ignoresSafeArea()
            content()
        }
    }
}

#Preview {
    TabBarBackground {
        EmptyView()
    }
}
