//
//  TabBarViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 04.11.2025.
//

import SwiftUI

final class TabBarViewModel: ObservableObject {
 
    @Published var selected: Tab = .popular
//    @Binding var selected: Binding(
//        get: { selectedTab },
//        set: { selectedTab = $0 }
//    ),
    @Published private(set) var user: LocalUser
    private let factory: AppFactory
    private let avPlayer: RadioPlayer

    init(
        user: LocalUser,
        factory: AppFactory,
        avPlayer: RadioPlayer
    ) {
        self.user = user
        self.factory = factory
        self.avPlayer = avPlayer
    }
    
    func makeTabView() -> AnyView {
        factory.makeTabView(for: selected)
    }
    
    func goToAllStations() {
        selected = .allStations
    }
    
    func goToPopular() {
        selected = .popular
        
    }
}
//extension TabBarViewModel {
//    enum Tab: Int { case popular, favorites, allStations }
//}
