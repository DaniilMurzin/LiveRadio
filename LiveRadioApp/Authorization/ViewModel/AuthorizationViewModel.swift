//
//  AuthorizationViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import Foundation

struct User {
    private init() {}
}

// Only Valid email!!!
struct Email: Equatable {
    let wrapped: String
    
    init?(_ email: String) {
        guard email.contains("@") && email.count > 7 else {
            return nil
        }
        self.wrapped = email
    }
    
    static func parce(_ email: String) -> Result<Email, EmailError> {
        .failure(.toShort)
    }
}

enum EmailError: Error {
    case toShort
    case nonEmail
}

struct Password: Equatable {
    let wrapped: String
    
    init?(_ password: String) {
        guard password.count > 8 else {
            return nil
        }
        self.wrapped = password
    }
}

// Valid!!!
struct Credentials: Equatable {
    let email: Email
    let password: Password
}

protocol AuthorizationService {
    func signIn(with: Credentials) async -> Result<User, Error>
}

protocol AppCoordinator {
    func goTabbar(_ user: User)
}

final class AuthorizationViewModel: ObservableObject {
    private let authorizationService: AuthorizationService
    private let coordinator: AppCoordinator
    
    @Published var state: State = .signIn
    
    @Published var email: String = .init()
    @Published var password: String = .init()
    
    @Published var name: String = .init()
    
    init(
        authorizationService: AuthorizationService,
        coordinator: AppCoordinator
    ) {
        self.authorizationService = authorizationService
        self.coordinator = coordinator
    }
    
    func forgotPassword() {
        state = .forgotPass
    }
    
    var signInActive: Bool {
        email.contains("@")
        && email.count > 7
        && password.count > 8
    }
    
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
    
    func signUp() {
        state = .signUp
    }
    
    func showSignIn() {
        state = .signIn
    }
}

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
