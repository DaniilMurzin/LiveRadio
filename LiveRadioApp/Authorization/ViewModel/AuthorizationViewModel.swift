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
}

protocol AppCoordinator {
    func goTabbar(_ user: User)
}

final class AuthorizationViewModel: ObservableObject {
    
    //MARK: - Properties
    private let authorizationService: AuthorizationService
    private let coordinator: AppCoordinator
    
    @Published var state: State = .signIn
    
    @Published var email: String = .init()
    @Published var password: String = .init()
    
    @Published var name: String = .init()
    
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
        coordinator: AppCoordinator
    ) {
        self.authorizationService = authorizationService
        self.coordinator = coordinator
    }
    
    //MARK: - Navigation methods
    func signIn() async {
        guard
            let email = Email(email),
            let password = Password(password)
        else {
            return
        }
        
        let credentials = Credentials(email: email, password: password)
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
        guard
        let email = Email(email),
        let password = Password(password)
    else {
        return
    }
    
    let credentials = Credentials(email: email, password: password)
    let result = await authorizationService.signUp(with: credentials)
    
    await MainActor.run {
        switch result {
        case .success(let user):
            coordinator.goTabbar(user)
            
        case .failure(let error):
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
