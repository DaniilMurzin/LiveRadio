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
                    .tabItem {
                        VStack {
                            Text("Popular")
                            Circle()
                                .stroke(.eclipse6, lineWidth: 1)
                                .background(Circle().fill(.eclipse8))
                                .frame(width: 8, height: 8)

                        }
                    }
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
