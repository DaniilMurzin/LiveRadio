//
//  FactorySpy.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.10.2024.
//

import SwiftUI
import OSLog



// MARK: - FactorySpy
struct FactorySpy {
    private let logger = Logger(subsystem: "RootFactory", category: "System")
    let rootFactory: RootFactory
    let mainFlowFactory: MainFlowFactory
    let repository: Repository
}

// MARK: - FactorySpy + RootFactory
extension FactorySpy: RootFactory, MainFlowFactory {
    func makeTabView(for tab: Tab) -> AnyView {
        logger.trace(#function)
        return mainFlowFactory.makeTabView(for: tab)
    }
    
    func makeTabBar(user: LocalUser) -> TabBarContentView {
        logger.trace(#function)
        return rootFactory.makeTabBar(user: user)
    }
    
    func makeProfile(user: LocalUser) -> ProfileContentView {
        logger.trace(#function)
        return mainFlowFactory.makeProfile(user: user)
    }
    
    func makeAllStations() -> AllStationsContentView {
        logger.trace(#function)
        return mainFlowFactory.makeAllStations()
    }
    
    func makeFavorites() -> FavoritesContentView {
        logger.trace(#function)
        return mainFlowFactory.makeFavorites()
    }
    
    func makeDetails() -> DetailsContentView {
        logger.trace(#function)
        return mainFlowFactory.makeDetails()
    }
    
    func makePopular() -> PopularContentView {
        logger.trace(#function)
        return mainFlowFactory.makePopular()
    }
    
    
    func makeTabBar(user: LocalUser, coordinator: AppCoordinator) -> TabBarContentView {
        logger.trace(#function)
        return rootFactory.makeTabBar(user: user)
    }
    
    func makeOnboarding() -> OnboardingContentView {
        logger.trace(#function)
        return rootFactory.makeOnboarding()
    }
    
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView {
        logger.trace(#function)
        return rootFactory.makeAuthorization(coordinator: coordinator)
    }
}

// MARK: - FactorySpy + Repository
extension FactorySpy: Repository {
    func fetchOnboarding() async -> [String] {
        logger.trace(#function)
        return await repository.fetchOnboarding()
    }
}
