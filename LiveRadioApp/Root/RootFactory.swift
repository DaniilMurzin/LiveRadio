//
//  RootFactory.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//
//#warning("""
//1)Обьяснение протоколов, почему не используем конкретный тип, а протокол?Тестирование? это и есть DI? 
//2) ObserObject не используем, так как фабрика просто создает экземпляры и не хранит состояний?
//""")
import Foundation
import SwiftUI
import OSLog

/// Какое-то логирование
struct FactorySpy {
    private let logger = Logger(subsystem: "RootFactory", category: "System")
    let factory: RootFactory
    let repository: Repository
}

extension FactorySpy: RootFactory {
    func makeOnboarding() -> OnboardingContentView {
        logger.trace(#function)
        return factory.makeOnboarding()
    }
    
    func makeAuthorization() -> AuthorizationContentView {
        logger.trace(#function)
        return factory.makeAuthorization()
    }
}

extension FactorySpy: Repository {
    func fetchOnboarding() async -> [String] {
        logger.trace(#function)
        return await repository.fetchOnboarding()
    }
}

final class AppRepository: Repository {
    func fetchOnboarding() -> [String] {
        []
    }
}

final class FRoot: RootFactory {
    private let repository = AppRepository()
    private(set) lazy var spy = FactorySpy(
        factory: self,
        repository: repository
    )
    
    static func makeRootCoordinator() -> RootCoordinator {
        return RootCoordinator(factory: FRoot().spy)
    }
    
    func makeOnboarding() -> OnboardingContentView {
        let viewModel = OnboardingViewModel(repository: spy)
        return OnboardingContentView(viewModel)
    }
        
    func makeAuthorization() -> AuthorizationContentView {
        let viewModel = AuthorizationViewModel()
        return AuthorizationContentView(viewModel)
    }
    
}
