//
//  AuthorizationManager.swift
//  RadioApp
//
//  Created by Daniil Murzin on 25.10.2025.
//

import Foundation
import FirebaseAuth

protocol AuthorizationService {
    func signIn(with: Credentials) async -> Result<User, Error>
    func signUp(with: Credentials) async -> Result<User, Error>
    func getCurrentUser() -> Result<User, AuthServiceError>
    func signOut() throws
    func resetPassword(email: String) async throws
    func updatePassword(password: String) async -> Result<String, Error>
}

final class AuthorizationManager: AuthorizationService {
    
    var dbUser: FirebaseAuth.User? { Auth.auth().currentUser }

//    func getCurrentUser() throws -> User {
//        guard let user = dbUser else
//        { throw AuthServiceError.noCurrentUser }
//        return User(user)
//    }
    
    func getCurrentUser() -> Result<User, AuthServiceError> {
        Result {
            guard let user = dbUser else {
                throw AuthServiceError.noCurrentUser
            }
            return user
        }
        .map(User.init)
        .mapError { $0 as! AuthServiceError }
    }
    
//    func updatePassword(password: String) async throws {
//        guard let user = dbUser else {
//            throw AuthServiceError.noCurrentUser
//        }
//        try await user.updatePassword(to: password)
//    }
    
    func updatePassword(password: String) async -> Result<String, Error> {
        await Result<String, Error> {
            guard let user = dbUser else { throw AuthServiceError.noCurrentUser }
            try await user.updatePassword(to: password)
            return password
        }
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthServiceError.noCurrentUser
        }
        
        try await user.sendEmailVerification()
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func signUp(with credentials: Credentials) async -> Result<User, Error> {
        await Result<Credentials, Error>
            .success(credentials)
            .map(\.credentials)
            .asyncTryMap(Auth.auth().createUser)
            .map(\.user)
            .map(User.init)
    }
    
    func signIn(with credentials: Credentials) async -> Result<User, Error> {
        await Result<Credentials, Error>
            .success(credentials)
            .map(\.credentials)
            .asyncTryMap(Auth.auth().signIn(withEmail:password:))
            .map(\.user)
            .map(User.init)
    }
    
    func signOut() throws   {
       try Auth.auth().signOut()
    }
}


extension User {
    init(_ firebaseUser: FirebaseAuth.User) {
        self.init(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            name: firebaseUser.displayName ?? "" ,
            photoURL: firebaseUser.photoURL?.absoluteString ?? ""
        )
    }
}

extension Credentials {
    var credentials: (email: String, password: String) {
        (email.wrapped, password.wrapped)
    }
}
