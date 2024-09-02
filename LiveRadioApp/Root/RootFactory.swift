//
//  RootFactory.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation

protocol RootFactory {
    func makeOnboarding() -> OnboardingViewModel
}

final class FRoot: RootFactory {
    
    static func makeRootCoordinator() -> RootCoordinator {
        RootCoordinator(factory: FRoot())
    }
    
    func makeOnboarding() -> OnboardingViewModel {
        OnboardingViewModel()
    }
    
}
