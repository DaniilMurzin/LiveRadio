//
//  ProfileViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 19.08.2025.
//

import Foundation

#warning("ревью")
final class ProfileViewModel: ObservableObject {
    
//    private let serviceLocator: Services
    private let dependancies: Dependencies
    
    @Published private(set) var user: LocalUser
    @Published private(set) var error: Error?
    @Published var notificationEnabled: Bool = false
    
    
    init(
        user: LocalUser,
        dependancies: Dependencies
    ) {
        self.user = user
        self.dependancies = dependancies
    }

    func loadCurrentUser() async  {
        
        let currentUser =  await Result(catching: dependancies.getCurrentUser)
        do {
            let authDataResult = dependancies.getCurrentUser()
        } catch {
            //TODO: show banner/retry/
            self.error = error
        }
    }
    
    func signOut() throws {
        try dependancies.signOut()
    }
    
    func toggleNotifications() {
        
    }
    
    func changeUserName(_ newName: String) async throws {
        try await dependancies.updateUsersName(newName, user.id)
    }
}

extension ProfileViewModel {
    struct Dependencies {
        var getCurrentUser: () -> Result<LocalUser, AuthServiceError>
        var signOut: () throws -> Void
        var updateUsersName: (String, DBUser.ID) async throws -> Void
        
        init(
            getCurrentUser: @escaping () -> Result<LocalUser, AuthServiceError>,
            signOut: @escaping () throws -> Void,
            updateUsersName: @escaping (String, DBUser.ID) async  throws -> Void
        ) {
            self.getCurrentUser = getCurrentUser
            self.signOut = signOut
            self.updateUsersName = updateUsersName
        }
        
        init(
            authorizationManager: AuthorizationService,
            storageManager: StorageService,
            userManager: UserRepository
        ) {
            self.init(
                getCurrentUser: authorizationManager.getCurrentUser,
                signOut: authorizationManager.signOut,
                updateUsersName: userManager.updateUsersName
            )
        }
    }
}

//
//protocol Services  {
//    var authorizationManager: AuthorizationService { get }
//    var storageManager: StorageService { get }
//    var userManager: UserRepository { get }
//    
//    func getCurrentUser() -> Result<LocalUser, AuthServiceError>
//    func signOut() throws
//    func updateUsersName(_ newName: String, id: DBUser.ID) async throws
//}
//
//extension Services {
//    func getCurrentUser() -> Result<LocalUser, AuthServiceError> {
//        authorizationManager.getCurrentUser()
//    }
//    func signOut() throws {
//        try authorizationManager.signOut()
//    }
//    
//    func updateUsersName(_ newName: String, id: DBUser.ID) async throws {
//        try await userManager.updateUsersName(newName, id: id)
//    }
//}
