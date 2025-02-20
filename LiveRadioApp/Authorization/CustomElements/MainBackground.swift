//
//  MainBackground.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 11.09.2024.
//

import SwiftUI

struct MainBackground<V: View>: View {
    private let padding: CGFloat = 30
    
    let content: () -> V
    
    init(@ViewBuilder content: @escaping () -> V) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Image(.authBG)
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .leading, content: content)
        }
        .background(.mainBg)
    }
}

#Preview {
    MainBackground {
        EmptyView()
    }
}
