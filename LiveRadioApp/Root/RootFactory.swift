//
//  RootFactory.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//
#warning("Обьяснение протоколов, почему не используем конкретный тип, а протокол?Тестирование? это и есть DI?")
import Foundation

protocol RootFactory {
    func makeOnboarding() -> OnboardingViewModel
    func makeAuthorization() -> AuthorizationViewModel 
}

final class FRoot: RootFactory {
    
    static func makeRootCoordinator() -> RootCoordinator {
        RootCoordinator(factory: FRoot())
    }
    
    func makeOnboarding() -> OnboardingViewModel {
        OnboardingViewModel()
    }
    
    func makeAuthorization() -> AuthorizationViewModel {
        AuthorizationViewModel()
    }
    
}
