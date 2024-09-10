//
//  RootCoordinator.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation

final class RootCoordinator: ObservableObject {
    private let factory: RootFactory
    
    @Published var state: Path
    
    init(factory: RootFactory, state: Path = .loading) {
        self.factory = factory
        self.state = state
    }
    
    func showOnboarding() {
        state = .onboarding(factory.makeOnboarding())
    }
    
    func showAuthorization() {
        state = .authorization(factory.makeAuthorization())
    }
}

extension RootCoordinator {
    enum Path {
        case loading
        case error
        case onboarding(OnboardingViewModel)
        case authorization(AuthorizationViewModel)
        case tabbar
    }
}
