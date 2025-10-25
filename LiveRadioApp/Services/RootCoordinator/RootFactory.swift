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
    func makeAllStations() -> AllStationsContentView
    func makeProfile(user: User) -> ProfileContentView
}

final class FRoot {
    private let repository = AppRepository()
    private let networkService = NetworkService()
    private let authorizationService = AuthorizationManager()
    private let player = RadioPlayer()
    private let storageManager = CoreDateManager()
    private let userManager = UserManager()
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
    
    func makeProfile(user: User) -> ProfileContentView {
        let viewModel = ProfileViewModel(
            user: user,
            networkService: networkService,
            storageManager: storageManager,
            authorizationService: authorizationService,
            userManager: userManager)
        return ProfileContentView(viewModel)
    }
    
   
    func makeTabBar() -> TabBarView {
        TabBarView(factory: self)
    }
    
    func makeOnboarding() -> OnboardingContentView {
        let viewModel = OnboardingViewModel(repository: spy)
        return OnboardingContentView(viewModel)
    }
    
    func makeFavorites() -> FavoritesContentView {
        let viewModel = FavoritesViewModel(avPlayer: player, storageManager: storageManager)
        return FavoritesContentView(viewModel)
    }
    
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView {
        let viewModel = AuthorizationViewModel(
            authorizationService: authorizationService,
            coordinator: coordinator,
            userManager: userManager
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
    
    func makeAllStations() -> AllStationsContentView {
        let viewModel = AllStationsViewModel(
            networkService: networkService,
            avPlayer: player,
            storageManager: storageManager
        )
        return AllStationsContentView(viewModel)
    }
}

final class AppRepository: Repository {
    func fetchOnboarding() -> [String] {
        []
    }
}
