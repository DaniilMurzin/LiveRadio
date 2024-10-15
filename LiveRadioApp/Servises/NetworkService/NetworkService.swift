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
3) API.scheme покрывать протоколом и делать DI избыточно? 
""")

final class NetworkService  {
    //MARK: - properties
    private let session: URLSession
    private let apiСonfiguration: APIConfiguration
    
    init(session: URLSession, APIConfiguration: APIConfiguration) {
        self.session = session
        self.apiСonfiguration = APIConfiguration
    }

    
  private func createURLRequest(for endpoint: Endpoint) -> URL?  {
        
      var components = URLComponents()
      components.scheme = apiСonfiguration.scheme
      components.host = apiСonfiguration.host
      components.path = endpoint.path
      
      return components.url
    }
    
    
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
