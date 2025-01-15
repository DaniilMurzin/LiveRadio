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

final class NetworkService {
    typealias NetworkRequest = (URLRequest) async throws -> (Data, URLResponse)
    
    //MARK: - Dependencies
    struct Dependencies {
        var request: (URLRequest) async throws -> (Data, URLResponse)
        var createUser: (String, String) async throws -> User
        var signIn: (String, String) async throws -> User
        
        static var live: Self {
            
            return Dependencies(
                request: URLSession.shared.data,
                createUser: { email, password in
                    try await Result {
                        try await Auth.auth().createUser(withEmail: email, password: password)
                    }
                    .map(\.user)
                    .map(User.init)
                    .get()
                },
                signIn: { email, password in
                    try await Result {
                        try await Auth.auth().signIn(withEmail: email, password: password)
                    }
                    .map(\.user)
                    .map(User.init)
                    .get()
                }
            )
        }
    }
    
    //MARK: - properties
    private let decoder = JSONDecoder()
    private var dependencies: Dependencies
    
    //MARK: - init(_:)
    init(_ dependencies: Dependencies = .live) {
        self.dependencies = dependencies
        decoder.dateDecodingStrategy = .iso8601
    }
}

//MARK: - NetworkService + StationDataService
extension NetworkService: StationDataService {
    
    func fetchTop() async throws -> [Station] {
        guard let url = Endpoint.popular.createURL() else {
            throw NetworkError.invalidURL
        }
        return try await makeRequest(for: url)
    }
}

//MARK: - NetworkService + AuthorizationService
extension NetworkService: AuthorizationService {
    
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
}

private extension NetworkService {
    //MARK: - Private methods
    
    func makeRequest<T:Codable>(for url: URL, maxRetries: Int = 3) async throws -> T {
        
        var retries = 0
        
        while retries < maxRetries {
            do {
                let request = URLRequest(url: url)
                let (data, response) = try await dependencies.request(request)
                
                guard !data.isEmpty else {
                    throw NetworkError.noData
                }
                
                try checkResponse(response)
                return try decoder.decode(T.self, from: data)
                
            } catch NetworkError.serviceUnavailable where retries < maxRetries {
                retries += 1
                print("Service unavailable, retrying... (\(retries)/\(maxRetries))")
                try await Task.sleep(nanoseconds: 2_000_000_000)
            } catch {
                throw error
            }
        }
        throw NetworkError.serviceUnavailable
    }
}

func checkResponse(_ response: URLResponse) throws {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw NetworkError.invalidResponse(response)
    }
    if let error  = NetworkError(statusCode: httpResponse.statusCode) {
        throw error
    }
}

fileprivate extension User {
    init(_ firebaseUser: FirebaseAuth.User) {
        self.init(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? ""
        )
    }
}

fileprivate extension Credentials {
    var credentials: (email: String, password: String) {
        (email.wrapped, password.wrapped)
    }
}
