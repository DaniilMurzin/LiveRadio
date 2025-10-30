//
//  AuthorizationViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import Foundation

protocol AppCoordinator {
    func goTabbar(_ user: LocalUser)
}

final class AuthorizationViewModel: ObservableObject {
    
    //MARK: - Properties
    private let authorizationManager: AuthorizationService
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
        authorizationManager: AuthorizationService,
        coordinator: AppCoordinator,
        userManager: UserRepository
    ) {
        self.authorizationManager = authorizationManager
        self.coordinator = coordinator
        self.userManager = userManager
    }
    
    //MARK: - Navigation methods
    func signIn() async {
        
        guard let credentials = Credentials(email: email, password: password) else { return }
        
        let result = await authorizationManager.signIn(with: credentials)
        
        await MainActor.run {
            switch result {
            case .success(let user):
                coordinator.goTabbar(user)
                
            case .failure(let error):
                state = .error(error)
            }
        }
    }
    
    @MainActor
    func signUp() async {
        let signUpResult = await Credentials
            .parse(email: email, password: password)
            .asyncFlatMap(authorizationManager.signUp(with:))
            .asyncFlatMap(userManager.newUserResult(user:))
        
        switch signUpResult {
            
        case let .success(user):
            coordinator.goTabbar(user)
        case let .failure(failure):
            state = .error(failure)
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
