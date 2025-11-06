//
//  RootCoordinator.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

final class RootCoordinator: ObservableObject {
    let factory: RootFactory
    
    @Published var state: Path
    
    init(factory: RootFactory, state: Path = .loading) {
        self.factory = factory
        self.state = state
    }
    
    func showOnboarding() {
        state = .onboarding
    }
    
    func showAuthorization() {
        state = .authorization
    }
    
    func showTabBar(user: LocalUser) {
        state = .tabbar(user)
    }
}

extension RootCoordinator: AppCoordinator {
    func goToPopular() {
        
    }
    
    func goToAllStations() {
        
    }
    
    func goToFavorites() {
        
    }
    
    func goTabbar(_ user: LocalUser) {
        showTabBar(user: user)
    }
}

extension RootCoordinator {
    enum Path {
        case loading
        case error
        case onboarding
        case authorization
        case tabbar(LocalUser)
    }
}
