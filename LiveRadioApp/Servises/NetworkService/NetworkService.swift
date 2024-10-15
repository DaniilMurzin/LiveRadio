//
//  NetworkService.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.10.2024.
//

import Foundation
//import FirebaseAuth

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

    
  private func createURL(for endpoint: Endpoint) -> URL?  {
        
      var components = URLComponents()
      components.scheme = apiСonfiguration.scheme
      components.host = apiСonfiguration.host
      components.path = endpoint.path
      
      components.queryItems = makeParameters(endpoint: endpoint).compactMap {
              
          URLQueryItem(name: $0.key, value: $0.value)
      }
      
      return components.url
    }
    
    private func makeParameters(endpoint: Endpoint) -> [String:String] {
        
        var parameters = [String:String] ()
        
        switch endpoint {
        case .popular:
            parameters["limit"] = "20"
            parameters["hidebroken"] = "true"
        }
        return parameters
    }
    
    private func makeRequest<T:Codable>(
        for url: URL,
        using session: URLSession = .shared
    ) async throws -> T {
        let request = URLRequest(url: url)
        
        let (data,response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
              }
        
        if !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: "Server error occurred")
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func fetchTop(for request: String) async throws -> [Station] {
        guard let url = createURL(for: .popular) else {
               throw NetworkError.invalidURL
           }
           
           return try await makeRequest(for: url)
       }
//
//    func fetchPopular(for request: String) async throws -> [Station] {
//        guard let url = createURL(for: .popular) else { throw
//            NetworkError.invalidURL
//        }

        
    }
    
//}

////MARK: - NetworkService + AuthorizationService
//extension NetworkService: AuthorizationService {
//
//    //MARK: - Authorization methods
//    func signUp(with credentials: Credentials) async -> Result<User, any Error> {
//        do {
//            let authResult = try await Auth.auth().createUser(withEmail: credentials.email.wrapped, password: credentials.password.wrapped)
//
//            let user = mapFirebaseUser(authResult.user)
//            return .success(user)
//        } catch {
//
//            return .failure(error)
//        }
//    }
//
//
//    func signIn(with credentials: Credentials) async -> Result<User, any Error> {
//
//        do {
//            let authResult = try await Auth.auth().signIn(withEmail: credentials.email.wrapped, password: credentials.password.wrapped)
//
//            let user = mapFirebaseUser(authResult.user)
//            return .success(user)
//        } catch {
//
//            return .failure(error)
//        }
//    }
//
//    private func mapFirebaseUser(_ firebaseUser: FirebaseAuth.User) -> User {
//        User(id: firebaseUser.uid, email: firebaseUser.email ?? "")
//    }
//
//}