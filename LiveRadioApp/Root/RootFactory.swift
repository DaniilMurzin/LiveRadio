//
//  RootFactory.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//
#warning("1)Обьяснение протоколов, почему не используем конкретный тип, а протокол?Тестирование? это и есть DI? 2) ObserObject не используем, так как фабрика просто создает экземпляры и не хранит состояний?")
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
