//
//  TabBarView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 16.09.2024.
//

import SwiftUI

struct TabBarView: View {
    
    //MARK: - Properties
    let factory: RootFactory
    @State private var selectedTab: Tabs = .popular
    
    var body: some View {
        TabBarBackground {
                switch selectedTab {
                case .popular:
                    factory.makePopular()
                case .favorites:
                    factory.makeFavorites()
                case .allStations:
                    factory.makePopular()
                }
            
            HStack {
                makeTabBarButton(text: "Popular", tab: .popular)
                Spacer()
                makeTabBarButton(text: "Favorites", tab: .favorites)
                Spacer()
                makeTabBarButton(text: "All Stations", tab: .allStations)
            }
            .padding(.horizontal, 20)
        }
    }
    
    //MARK: - Methods
    private func makeTabBarButton(text: String, tab: Tabs) -> some View {
       
        Button {
                selectedTab = tab
        } label: {
            VStack {
                Text(text)
                    .font(.system(size: 20, weight: .medium))
                    .opacity(selectedTab == tab ? 1 : 0.2)
                    .foregroundColor(.white)
                Circle()
                    .fill(.eclipse6)
                    .frame(width: 15, height: 15)
                    .scaleEffect(selectedTab == tab ? 1 : 0.5)
                    .opacity(selectedTab == tab ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: selectedTab == tab)
            }
        }
        .background(.clear)
    }
}

extension TabBarView {
    enum Tabs: Int {
        case popular
        case favorites
        case allStations
    }
}

#Preview {
    TabBarView(factory: FRoot())
}
