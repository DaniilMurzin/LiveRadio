//
//  TabBarViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 04.11.2025.
//

import Foundation

final class TabBarViewModel: ObservableObject {
 
    @Published var selectedTab: Tab = .popular
    @Binding var selected: Binding(
        get: { selectedTab },
        set: { selectedTab = $0 }
    ),
    @Published private(set) var user: LocalUser
    private let coordinator: AppCoordinator
    private let avPlayer: RadioPlayer

    init(
        user: LocalUser,
        coordinator: AppCoordinator,
        avPlayer: RadioPlayer
    ) {
        self.user = user
        self.coordinator = coordinator
        self.avPlayer = avPlayer
    }
    
    func goToFavorites() {
        selectedTab = .favorites
    }
    
    func goToAllStations() {
        selectedTab = .allStations
    }
    
    func goToPopular() {
        selectedTab = .popular
        
    }
}
extension TabBarViewModel {
    enum Tab: Int { case popular, favorites, allStations }
}
