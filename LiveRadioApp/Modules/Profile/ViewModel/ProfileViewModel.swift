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
    
    @Published private(set) var user: User
    @Published private(set) var error: Error?
    @Published var notificationEnabled: Bool = false
    
    
    init(
        user: User,
        networkService: StationDataService,
        storageManager: StorageManager,
        authorizationService: AuthorizationService,
        userManager: UserRepository
    ) {
        self.user = user
        self.networkService = networkService
        self.storageManager = storageManager
        self.authorizationService = authorizationService
        self.userManager = userManager
    }

    func loadCurrentUser() async  {
        
        let currentUser =  await Result(catching:authorizationService.getCurrentUser)
        
        do {
            let authDataResult = authorizationService.getCurrentUser()
        } catch {
            //TODO: show banner/retry/
            self.error = error
        }
    }
    
    func signOut() throws {
        try authorizationService.signOut()
    }
    
    func toggleNotifications() {
        
    }
    
    func changeUserName(_ newName: String) async throws {
        try await userManager.updateUsersName(newName, id: user.userId)
    }
}
