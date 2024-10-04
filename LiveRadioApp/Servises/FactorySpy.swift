//
//  FactorySpy.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.10.2024.
//

import Foundation
import OSLog


// MARK: - FactorySpy
struct FactorySpy {
    private let logger = Logger(subsystem: "RootFactory", category: "System")
    let factory: RootFactory
    let repository: Repository
}

// MARK: - FactorySpy + RootFactory
extension FactorySpy: RootFactory {
    func makeDetails() -> DetailsContentView {
        logger.trace(#function)
        return factory.makeDetails()
    }
    
    func makePopular() -> PopularContentView {
        logger.trace(#function)
        return factory.makePopular()
    }
    
    
    func makeTabBar() -> TabBarView {
        logger.trace(#function)
        return factory.makeTabBar()
    }
    
    func makeOnboarding() -> OnboardingContentView {
        logger.trace(#function)
        return factory.makeOnboarding()
    }
    
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView {
        logger.trace(#function)
        return factory.makeAuthorization(coordinator: coordinator)
    }
}

// MARK: - FactorySpy + Repository
extension FactorySpy: Repository {
    func fetchOnboarding() async -> [String] {
        logger.trace(#function)
        return await repository.fetchOnboarding()
    }
}
