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
    func makeTabBar(user: LocalUser) -> TabBarContentView
    
}

protocol MainFlowFactory {
    func makePopular() -> PopularContentView
    func makeFavorites() -> FavoritesContentView
    func makeDetails() -> DetailsContentView
    func makeAllStations() -> AllStationsContentView
    func makeProfile(user: LocalUser) -> ProfileContentView
    func makeTabView(for tab: Tab) -> AnyView
}

final class AppFactory {
    
    private let serviceLocator = ServiceLocator()
    private let repository = AppRepository()
    private let networkManager = NetworkManager()
    private let authorizationManager = AuthorizationManager()
    private let player = RadioPlayer()
    private let storageManager = CoreDateManager()
    private let userManager = UserManager()
    private(set) lazy var spy = FactorySpy(
        rootFactory: self,
        mainFlowFactory: self,
        repository: repository
    )
    
    static func makeRootCoordinator() -> RootCoordinator {
        return RootCoordinator(factory: AppFactory().spy)
    }
    
    init() {
        serviceLocator.register(AuthorizationManager.self)
        serviceLocator.register(CoreDateManager.self)
        serviceLocator.register(UserManager.self)
    }
}

extension AppFactory: RootFactory {
    
//    func makeTabBar(user: LocalUser) -> TabBarContentView  {
//        let viewModel = TabBarViewModel(
//            user: user,
//            factory: self,
//            avPlayer: player
//        )
//        return TabBarContentView(viewModel)
//    }
    
    func makeTabBar(user: LocalUser) -> TabBarContentView  {
        let vm = TabBarViewModel(user: user, factory: self, avPlayer: player)
        return TabBarContentView(vm)
    }
    
    func makeOnboarding() -> OnboardingContentView {
        let viewModel = OnboardingViewModel(repository: spy)
        return OnboardingContentView(viewModel)
    }
    
    func makeAuthorization(coordinator: AppCoordinator) -> AuthorizationContentView {
        let viewModel = AuthorizationViewModel(
            authorizationManager: authorizationManager,
            coordinator: coordinator,
            userManager: userManager
        )
        return AuthorizationContentView(viewModel)
    }

}

extension AppFactory: MainFlowFactory {
    
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
    
    func makeFavorites() -> FavoritesContentView {
        let viewModel = FavoritesViewModel(
            avPlayer: player,
            storageManager: storageManager
        )
        return FavoritesContentView(viewModel)
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
    
    
    func makeTabView(for tab: Tab) -> AnyView {
         switch tab {
         case .popular:     AnyView(makePopular())
         case .favorites:   AnyView(makeFavorites())
         case .allStations: AnyView(makeAllStations())
         }
     }
}

final class AppRepository: Repository {
    func fetchOnboarding() -> [String] {
        []
    }
}
