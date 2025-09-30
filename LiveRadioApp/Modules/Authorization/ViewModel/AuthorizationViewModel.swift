//
//  AuthorizationViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import Foundation

protocol AuthorizationService {
    func signIn(with: Credentials) async -> Result<User, Error>
    func signUp(with: Credentials) async -> Result<User, Error>
    func getCurrentUser() throws -> User
    func signOut() throws
    func resetPassword(email: String) async throws
}

protocol AppCoordinator {
    func goTabbar(_ user: User)
}

final class AuthorizationViewModel: ObservableObject {
    
    //MARK: - Properties
    private let authorizationService: AuthorizationService
    private let coordinator: AppCoordinator
    private let userManager: UserRepository
    
    @Published var state: State = .signIn
    @Published var email: String = .init()
    @Published var password: String = .init()
    @Published var name: String = .init()
    
//TODO: вычисляемое свой-во Credential
    //MARK: - Authentication properties
    var signInActive: Bool {
        email.contains("@")
        && email.count > 7
        && password.count > 6
    }
    
    var signUpActive: Bool {
        name.count > 3
        && email.contains("@")
        && email.count > 7
        && password.count > 6
    }
    //MARK: - Init
    init(
        authorizationService: AuthorizationService,
        coordinator: AppCoordinator,
        userManager: UserRepository
    ) {
        self.authorizationService = authorizationService
        self.coordinator = coordinator
        self.userManager = userManager
    }
    
    //MARK: - Navigation methods
    func signIn() async {
        
        guard let credentials = Credentials(email: email, password: password) else { return }
        
        let result = await authorizationService.signIn(with: credentials)
        
        await MainActor.run {
            switch result {
            case .success(let user):
                coordinator.goTabbar(user)
                
            case .failure(let error):
                state = .error(error)
            }
        }
    }
    
    func signUp() async {
        guard let credentials = Credentials(email: email, password: password) else { return }
        let result = await authorizationService.signUp(with: credentials)
        
        //    await MainActor.run {
        //        switch result {
//        case .success(let user):
//            coordinator.goTabbar(user)
//            userManager.createNewUser(user)
//            
//        case .failure(let error):
//            state = .error(error)
//        }
//    }
#warning("Ревью")
        switch result {
        case .success(let user):
            do {
                let DBUser =  DBUser(user)
                try await userManager.createNewUser(DBUser)
                await MainActor.run {
                    coordinator.goTabbar(user)
                }
            } catch {
                await MainActor.run {
                    state = .error(error)
                }
            }
            
        case .failure(let error):
            await MainActor.run {
                state = .error(error)
            }
        }
    }
    
    func showSignIn() {
        state = .signIn
    }
    
    func showSignUp() {
        state = .signUp
    }
    
    func forgotPassword() {
        state = .forgotPass
    }
}
//MARK: - AuthorizationViewModel + enum State
extension AuthorizationViewModel {
    //MARK: - State
    enum State: Equatable {
        case signIn
        case signUp
        case forgotPass
        case forgotPass2
        case error(Error)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
}
