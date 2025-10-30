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

final class NetworkManager {
    typealias NetworkRequest = (URLRequest) async throws -> (Data, URLResponse)
    
    //MARK: - Dependencies
    struct Dependencies {
        var request: (URLRequest) async throws -> (Data, URLResponse)
        var createUser: (String, String) async throws -> LocalUser
        var signIn: (String, String) async throws -> LocalUser
        
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
                    .map(LocalUser.init)
                    .get()
                },
                signIn: { email, password in
                    try await Result {
                        try await Auth.auth().signIn(withEmail: email, password: password)
                    }
                    .map(\.user)
                    .map(LocalUser.init)
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
extension NetworkManager: StationDataService {
    
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

private extension NetworkManager {
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
