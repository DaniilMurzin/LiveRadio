//
//  NetworkService.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.10.2024.
//

import Foundation
import FirebaseAuth

#warning(
"""
1)может на анкорах добавить реализацию?
2) Result или  throws ?  разница есть? или вкусовшина?
""")

final class NetworkService  {
    let url  = "http://all.api.radio-browser.info/json/stations/topvote?limit=10"
//    func fetchPopular(from url: String) async -> Result<[StationTest], any Error> {
//        
//        
//    }
    
    
}

//MARK: - NetworkService + AuthorizationService
extension NetworkService: AuthorizationService {
    
    //MARK: - Authorization methods
    func signUp(with credentials: Credentials) async -> Result<User, any Error> {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: credentials.email.wrapped, password: credentials.password.wrapped)
            
            let user = mapFirebaseUser(authResult.user)
            return .success(user)
        } catch {
            
            return .failure(error)
        }
    }
    
    
    func signIn(with credentials: Credentials) async -> Result<User, any Error> {
        
        do {
            let authResult = try await Auth.auth().signIn(withEmail: credentials.email.wrapped, password: credentials.password.wrapped)
            
            let user = mapFirebaseUser(authResult.user)
            return .success(user)
        } catch {
            
            return .failure(error)
        }
    }
    
    private func mapFirebaseUser(_ firebaseUser: FirebaseAuth.User) -> User {
        User(id: firebaseUser.uid, email: firebaseUser.email ?? "")
    }
    
}
