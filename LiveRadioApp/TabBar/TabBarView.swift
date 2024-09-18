//
//  TabBarView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 16.09.2024.
//

import SwiftUI

struct TabBarView: View {
    
    let factory: RootFactory
    
    var body: some View {
        TabView {
            factory.makePopular()
                .tabItem { Text("Popular") }
            EmptyView()
                .tabItem { Text("Favorites") }
            EmptyView()
                .tabItem { Text("All Stations") }
        }
    }
}

#Preview {
    TabBarView(factory: FRoot())
}
