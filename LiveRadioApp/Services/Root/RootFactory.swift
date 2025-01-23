//
//  RootFactory.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI
import AVFoundation

protocol RootFactory {
    func makeOnboarding() -> OnboardingContentView
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView
    func makePopular() -> PopularContentView
    func makeDetails() -> DetailsContentView
    func makeFavorites() -> FavoritesContentView
    func makeTabBar() -> TabBarView
}

final class FRoot {
    private let repository = AppRepository()
    private let favoritesDataService = FavoritesDataService()
    private let networkService = NetworkService()
    private let player = RadioPlayer()
    private let storageManager = CoreDateManager()
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
    
    func makeFavorites() -> FavoritesContentView {
        let viewModel = FavoritesViewModel(avPlayer: player, persistenceManager: favoritesDataService)
        return FavoritesContentView(viewModel)
    }
    
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView {
        let viewModel = AuthorizationViewModel(
            authorizationService: networkService,
            coordinator: coordinator
        )
        return AuthorizationContentView(viewModel)
    }
    
    func makePopular() -> PopularContentView {
        let viewModel = PopularViewModel(
            networkService: networkService,
            avPlayer: player,
            storageManager: storageManager
        )
        return PopularContentView(viewModel)
    }
    
    func makeDetails() -> DetailsContentView {
        let viewModel = DetailsViewModel()
        return DetailsContentView(viewModel)
    }
}

final class AppRepository: Repository {
    func fetchOnboarding() -> [String] {
        []
    }
}
