//
//  RootFactory.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation
import SwiftUI
import OSLog

// MARK: - FRoot
final class FRoot {
    private let repository = AppRepository()
    private(set) lazy var spy = FactorySpy(
        factory: self,
        repository: repository
    )
    
    static func makeRootCoordinator() -> RootCoordinator {
        return RootCoordinator(factory: FRoot().spy)
    }
}

// MARK: - FRoot + RootFactory
extension FRoot: RootFactory {
    
    func makeTabBar() -> TabBarView {
        TabBarView(factory: self)
    }
    
    func makeOnboarding() -> OnboardingContentView {
        let viewModel = OnboardingViewModel(repository: spy)
        return OnboardingContentView(viewModel)
    }
    
    func makeAuthorization() -> AuthorizationContentView {
        let viewModel = AuthorizationViewModel()
        return AuthorizationContentView(viewModel)
    }
    
    func makePopularView() -> PopularContentView {
        let viewModel = PopularViewModel()
        return PopularContentView(viewModel)
    }
}

// MARK: - FactorySpy
struct FactorySpy {
    private let logger = Logger(subsystem: "RootFactory", category: "System")
    let factory: RootFactory
    let repository: Repository
}

// MARK: - FactorySpy + RootFactory
extension FactorySpy: RootFactory {
    
    func makePopularView() -> PopularContentView {
        logger.trace(#function)
        return factory.makePopularView()
    }
    
    
    func makeTabBar() -> TabBarView {
        logger.trace(#function)
        return factory.makeTabBar()
    }
    
    func makeOnboarding() -> OnboardingContentView {
        logger.trace(#function)
        return factory.makeOnboarding()
    }
    
    func makeAuthorization() -> AuthorizationContentView {
        logger.trace(#function)
        return factory.makeAuthorization()
    }
}

// MARK: - FactorySpy + Repository
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
