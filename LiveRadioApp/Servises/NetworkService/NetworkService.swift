//
//  NetworkService.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.10.2024.
//

import Foundation
import FirebaseAuth

protocol StationDataService {
    func fetchTop() async throws -> [Station]
}

final class NetworkService  {
    
    typealias NetworkRequest = (URLRequest) async throws -> (Data, URLResponse)
    //MARK: - properties
    private let networkRequest: NetworkRequest
    private let apiСonfiguration = API()
    private let decoder = JSONDecoder()
    
    init(networkRequest: @escaping NetworkRequest = URLSession.shared.data) {
        self.networkRequest = networkRequest
    }
    
    private func createURL(for endpoint: Endpoint) -> URL?  {
        
        var components = URLComponents()
        components.scheme = apiСonfiguration.scheme
        components.host = apiСonfiguration.host
        components.path = endpoint.path
        components.queryItems = makeParameters(endpoint: endpoint).map {
            
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return components.url
    }
    
    private func makeParameters(endpoint: Endpoint) -> [String:String] {
        
        var parameters = [String:String] ()
        
        switch endpoint {
        case .popular:
            parameters["limit"] = "6"
            parameters["hidebroken"] = "true"
        }
        return parameters
    }
    
    private func makeRequest<T:Codable>(for url: URL) async throws -> T {
        
        let request = URLRequest(url: url)
        
        let (data,response) = try await networkRequest(request)
        
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
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

//MARK: - NetworkService + StationDataService
extension NetworkService: StationDataService {
    
    func fetchTop() async throws -> [Station] {
        guard let url = createURL(for: .popular) else {
            throw NetworkError.invalidURL
        }
        
        return try await makeRequest(for: url)
    }
}


//MARK: - NetworkService + AuthorizationService
extension NetworkService: AuthorizationService {
    
    //MARK: - Authorization methods
    func signUp(with credentials: Credentials) async -> Result<User, any Error> {
        do {
            let authResult = try await Auth.auth().createUser(
                withEmail: credentials.email.wrapped,
                password: credentials.password.wrapped
            )
            
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

fileprivate extension User {
    init(_ firebaseUser: FirebaseAuth.User) {
        self.init(id: firebaseUser.uid, email: firebaseUser.email ?? "")
    }
    
}
