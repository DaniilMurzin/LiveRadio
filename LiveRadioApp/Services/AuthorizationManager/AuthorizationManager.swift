//
//  AuthorizationManager.swift
//  RadioApp
//
//  Created by Daniil Murzin on 25.10.2025.
//

import Foundation
import FirebaseAuth

protocol AuthorizationService {
    func signIn(with: Credentials) async -> Result<LocalUser, Error>
    func signUp(with: Credentials) async -> Result<LocalUser, Error>
    func getCurrentUser() -> Result<LocalUser, AuthServiceError>
    func signOut() throws
    func resetPassword(email: String) async throws
    func updatePassword(_ password: Password) async -> Result<String, Error>
    func updateEmail(email: Email) async throws
}

final class AuthorizationManager  {
    var dbUser: FirebaseAuth.User? { Auth.auth().currentUser }
}

extension AuthorizationManager: AuthorizationService {
   
    func getCurrentUser() -> Result<LocalUser, AuthServiceError> {
        Result {
            guard let user = dbUser else { throw AuthServiceError.noCurrentUser }
            return user
        }
        .map(LocalUser.init)
        .mapError { $0 as! AuthServiceError }
    }
    
    func updatePassword(_ password: Password) async -> Result<String, Error> {
        await Result  {
            guard let user = dbUser else { throw AuthServiceError.noCurrentUser }
            try await user.updatePassword(to: password.wrapped)
            return password.wrapped
        }
    }
    
    func resetPassword(email: Email) async -> Result<Void, Error> {
        await Result {
            try await Auth.auth().sendPasswordReset(withEmail: email.wrapped)
             return ()
         }
    }
    
    func updateEmail(email: Email) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthServiceError.noCurrentUser
        }
        
        try await user.sendEmailVerification()
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func signUp(with credentials: Credentials) async -> Result<LocalUser, Error> {
        await Result<Credentials, Error>
            .success(credentials)
            .map(\.credentials)
            .asyncTryMap(Auth.auth().createUser)
            .map(\.user)
            .map(LocalUser.init)
    }
    
    func signIn(with credentials: Credentials) async -> Result<LocalUser, Error> {
        await Result<Credentials, Error>
            .success(credentials)
            .map(\.credentials)
            .asyncTryMap(Auth.auth().signIn(withEmail:password:))
            .map(\.user)
            .map(LocalUser.init)
    }
    
    func signOut() throws   {
       try Auth.auth().signOut()
    }
}

extension AuthorizationManager: Dependency {}
