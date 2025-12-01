//
//  TabBarViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 04.11.2025.
//

import SwiftUI

final class TabBarViewModel: ObservableObject {
 
    @Published var selected: Tab = .popular
    @Published private(set) var user: LocalUser
    
    private let avPlayer: RadioPlayer
    let coordinator: MainFlowCoordinator

    init(
        user: LocalUser,
        avPlayer: RadioPlayer,
        coordinator: MainFlowCoordinator
    ) {
        self.user = user
        self.avPlayer = avPlayer
        self.coordinator = coordinator
    }
    
    func didSelect(tab: Tab) {
        selected = tab
        coordinator.goToTab(tab)
    }
}
