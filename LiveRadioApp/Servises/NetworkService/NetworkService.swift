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
        var createUser: (String, String) async throws -> AuthDataResult
        var signIn: (String, String) async throws -> AuthDataResult
        
        static var live: Self {
            
            return Dependencies(
                request: URLSession.shared.data,
                createUser: { email, password in
                    try await Auth.auth().createUser(withEmail: email, password: password)
                },
                signIn: { email, password in
                    try await Auth.auth().signIn(withEmail: email, password: password)
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
    
    //MARK: - Authorization methods
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
extension Result {
    @inlinable
    func asyncTryMap1<NewSuccess>(
        _ transform: (Success) async throws -> NewSuccess
    ) async -> Result<NewSuccess, Error> {
        switch self {
        case .success(let success):
            return await Result<NewSuccess, Error> {
                try await transform(success)
            }
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
private extension NetworkService {
    //MARK: - Private methods
    
    func makeRequest<T:Codable>(for url: URL, maxRetries: Int = 3) async throws -> T {
        
        var retries = 0
        
        while retries < maxRetries {
            do {
                let request = URLRequest(url: url)
            #warning("Если инит делать только через зависимости, не могу понять как сюда прокидывать свой-во dependency")
                let (data, response) = try await dependencies.request(request)
                
                guard !data.isEmpty else {
                    throw NetworkError.noData
                }
                
                try handleResponse(response)
                decoder.dateDecodingStrategy = .iso8601
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
    
      func handleResponse(_ response: URLResponse) throws {
          guard let httpResponse = response as? HTTPURLResponse else {
              throw NetworkError.invalidResponse
          }
          
          switch httpResponse.statusCode {
          case 200...299:
              return
          case 503:
              throw NetworkError.serviceUnavailable
          case 500...599:
              throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: "Server error occurred")
          case 400:
              throw NetworkError.badRequest(message: "Bad Request")
          case 401:

              throw NetworkError.unauthorized(message: "Unauthorized Access")
          case 403:
              throw NetworkError.forbidden(message: "Forbidden")
          case 404:
              throw NetworkError.notFound(message: "Resource Not Found")
          default:
              throw NetworkError.unknown
          }
      }
    }

extension Result where Failure == Error {
    @inlinable
    init(asyncCatch: () async throws -> Success) async {
        do {
            let success = try await asyncCatch()
            self = .success(success)
        } catch {
            self = .failure(error)
        }
    }
}

extension Result {
    @inlinable
    func asyncTryMap<NewSuccess>(
        _ transform: (Success) async throws -> NewSuccess
    ) async -> Result<NewSuccess, Error> {
        switch self {
        case .success(let success):
            return await Result<NewSuccess, Error> {
                try await transform(success)
            }
        case .failure(let failure):
            return .failure(failure)
        }
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
