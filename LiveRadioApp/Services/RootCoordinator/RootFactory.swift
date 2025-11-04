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
    func makeTabBar(user: LocalUser, coordinator: AppCoordinator) -> TabBarContentView
    func makeAllStations() -> AllStationsContentView
    func makeProfile(user: LocalUser) -> ProfileContentView
}

final class FRoot {
    private let serviceLocator = ServiceLocator()
    private let repository = AppRepository()
    private let networkManager = NetworkManager()
    private let authorizationManager = AuthorizationManager()
    private let player = RadioPlayer()
    private let storageManager = CoreDateManager()
    private let userManager = UserManager()
    private(set) lazy var spy = FactorySpy(factory: self, repository: repository)
    
    static func makeRootCoordinator() -> RootCoordinator {
        return RootCoordinator(factory: FRoot().spy)
    }
    
    init() {
        serviceLocator.register(AuthorizationManager.self)
        serviceLocator.register(CoreDateManager.self)
        serviceLocator.register(UserManager.self)
    }
}
#warning("Ревью func makeProfile(user: LocalUser) -> ProfileContentView")
// MARK: - FRoot + RootFactory
extension FRoot: RootFactory {
    
    func makeProfile(user: LocalUser) -> ProfileContentView {
        
        let auth: AuthorizationService = serviceLocator.resolve(AuthorizationManager.self)
        let userRepo: UserRepository = serviceLocator.resolve(UserManager.self)
        let storage: StorageService = serviceLocator.resolve(CoreDateManager.self)
        
        let deps = ProfileViewModel.Dependencies(
            authorizationManager: auth,
            storageManager: storage,
            userManager: userRepo
        )
        let viewModel = ProfileViewModel(
            user: user,
            dependancies: deps
        )
        return ProfileContentView(viewModel)
    }
    
    func makeTabBar(user: LocalUser, coordinator: AppCoordinator) -> TabBarContentView  {
        let viewModel = TabBarViewModel(
            user: user,
            coordinator: coordinator,
            avPlayer: player
        )
        return TabBarContentView(viewModel)
    }
    
    func makeOnboarding() -> OnboardingContentView {
        let viewModel = OnboardingViewModel(repository: spy)
        return OnboardingContentView(viewModel)
    }
    
    func makeFavorites() -> FavoritesContentView {
        let viewModel = FavoritesViewModel(
            avPlayer: player,
            storageManager: storageManager
        )
        return FavoritesContentView(viewModel)
    }
    
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView {
        let viewModel = AuthorizationViewModel(
            authorizationManager: authorizationManager,
            coordinator: coordinator,
            userManager: userManager
        )
        return AuthorizationContentView(viewModel)
    }
    
    func makePopular() -> PopularContentView {
        let viewModel = PopularViewModel(
            networkService: networkManager,
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
            networkService: networkManager,
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
