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
    func searchByName(name: String) async throws -> [Station]
}

final class NetworkService {
    typealias NetworkRequest = (URLRequest) async throws -> (Data, URLResponse)
    
    //MARK: - Dependencies
    struct Dependencies {
        var request: (URLRequest) async throws -> (Data, URLResponse)
        var createUser: (String, String) async throws -> User
        var signIn: (String, String) async throws -> User
        
        static var live: Self {
            
            let config = URLSessionConfiguration.default
            config.urlCache = URLCache(
                memoryCapacity: 1024 * 20,
                diskCapacity: 1024 * 20
            )
            let session = URLSession(configuration: config)
            
            return Dependencies(
                request: session.data,
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
        let url =  try URLComponents
            .topVotes()
            .unwrapURL()
        return try await makeRequest(for: url)
    }
    
    func searchByName(name: String) async throws -> [Station] {
       let url =  try URLComponents
            .search(name)
            .unwrapURL()
        return try await makeRequest(for: url)
    }
}

//MARK: - NetworkService + AuthorizationService
extension NetworkService: AuthorizationService {
    
    var dbUser: FirebaseAuth.User? { Auth.auth().currentUser }
#warning("Вынести Сервис из протокола в отдельный менеджер?")
    
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

private extension NetworkService {
    //MARK: - Private methods
    func makeRequest<T:Codable>(for url: URL, maxRetries: Int = 3) async throws -> T {
        
        do  {
            let request = URLRequest(url: url)
            let (data, response) = try await dependencies.request(request)
            guard !data.isEmpty else { throw NetworkError.noData }
            try checkResponse(response)
            return try decoder.decode(T.self, from: data)
        }
        catch  NetworkError.serviceUnavailable where maxRetries > 0 {
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
            return try await makeRequest(for: url, maxRetries: maxRetries - 1)
        }
        catch {
            throw error
        }
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
            email: firebaseUser.email ?? "",
            name: firebaseUser.displayName ?? "" ,
            photoURL: firebaseUser.photoURL?.absoluteString ?? ""
        )
    }
}

fileprivate extension Credentials {
    var credentials: (email: String, password: String) {
        (email.wrapped, password.wrapped)
    }
}
