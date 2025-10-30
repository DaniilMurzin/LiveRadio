//
//  ProfileViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 19.08.2025.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    private let authorizationManager: AuthorizationService
    private let storageManager: StorageService
    private let userManager: UserRepository
    
    @Published private(set) var user: LocalUser
    @Published private(set) var error: Error?
    @Published var notificationEnabled: Bool = false
    
    
    init(
        user: LocalUser,
        storageManager: StorageService,
        authorizationService: AuthorizationService,
        userManager: UserRepository
    ) {
        self.user = user
        self.storageManager = storageManager
        self.authorizationManager = authorizationService
        self.userManager = userManager
    }

    func loadCurrentUser() async  {
        
        let currentUser =  await Result(catching:authorizationManager.getCurrentUser)
        do {
            let authDataResult = authorizationManager.getCurrentUser()
        } catch {
            //TODO: show banner/retry/
            self.error = error
        }
    }
    
    func signOut() throws {
        try authorizationManager.signOut()
    }
    
    func toggleNotifications() {
        
    }
    
    func changeUserName(_ newName: String) async throws {
        try await userManager.updateUsersName(newName, id: user.id)
    }
}
