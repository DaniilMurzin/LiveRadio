//
//  ProfileViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 19.08.2025.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    private let networkService: StationDataService
    private let authorizationService: AuthorizationService
    private let storageManager: StorageManager
    private let userManager: UserRepository
    
    @Published private(set) var user: DBUser?
    @Published var notificationEnabled: Bool = false
    
    
    init(
        networkService: StationDataService,
        storageManager: StorageManager,
        authorizationService: AuthorizationService,
        userManager: UserRepository
    ) {
        self.networkService = networkService
        self.storageManager = storageManager
        self.authorizationService = authorizationService
        self.userManager = userManager
    }
#warning("Ревью")
    func loadCurrentUser() async throws {
        let authDataResult = try authorizationService.getCurrentUser()
        self.user = try await userManager.getUser(userId: authDataResult.id)
    }
    
    func signOut() throws {
        try authorizationService.signOut()
    }
    
    func toggleNotifications() {
        
    }
    
    func changeUserName(_ newName: String) async throws {
        guard let user else { return }
        _ = user.name ?? ""
        Task {
            try await userManager.updateUsersName(newName, userId: user.userId)
            self.user = try await userManager.getUser(userId: user.userId)
        }
    }
}
