//
//  RootFactory.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation
import SwiftUI
import OSLog

final class NetworkService: AuthorizationService {
    func signIn(with: Credentials) async -> Result<User, any Error> {
        .failure(URLError(.badURL))
    }
    
    
}

// MARK: - FRoot
final class FRoot {
    private let repository = AppRepository()
    private let networkService = NetworkService()
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
    
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView {
        let viewModel = AuthorizationViewModel(
            authorizationService: networkService,
            coordinator: coordinator
        )
        return AuthorizationContentView(viewModel)
    }
    
    func makePopular() -> PopularContentView {
        let viewModel = PopularViewModel()
        return PopularContentView(viewModel)
    }
    
    func makeDetails() -> DetailsContentView {
        let viewModel = DetailsViewModel()
        return DetailsContentView(viewModel)
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

final class AppRepository: Repository {
    func fetchOnboarding() -> [String] {
        []
    }
}
