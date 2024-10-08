//
//  RootCoordinator.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import SwiftUI

protocol RootFactory {
    func makeOnboarding() -> OnboardingContentView
    func makeAuthorization() -> AuthorizationContentView
    func makePopularView() -> PopularContentView
    func makeTabBar() -> TabBarView
}

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
    
    func showTabBar() {
        state = .tabbar
    }
}

extension RootCoordinator {
    enum Path {
        case loading
        case error
        case onboarding
        case authorization
        case tabbar
    }
}
