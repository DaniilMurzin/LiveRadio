//
//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by Daniil Murzin on 03.12.2024.
//

import Testing
import Foundation

@testable import LiveRadioApp

struct NetworkServiceTests {
    
    static let user = User(id: "123", email: "test12@example.com")
    static let credentials = Credentials(
        email: "test12@example.com",
        password: "pasword123"
    )!
    
    //MARK: - StationDataService tests
    @Test
    func fetchTop_success() async throws {
        // given - дано
        let expected = [Station.mock]
        let data = try JSONEncoder().encode(expected)
        
        let dependencies = NetworkService.Dependencies(
            request: { req in (data, makeResponse(req)) },
            createUser: { _, _ in fatalError("Not implemented") },
            signIn: { _, _ in fatalError("Not implemented") }
        )
        
        let sut = NetworkService(dependencies)
        
        // when - взаимодействие
        let stations = try await sut.fetchTop()
        
        // then - проверка результата
        #expect(stations == expected)
    }
    
    @Test
    func fetchTop_badStatusCode() async throws {
        // given - дано
        let expected = [Station.mock]
        let data = try JSONEncoder().encode(expected)
        let dependencies = NetworkService.Dependencies(
            request: { req in (data, makeResponse(req, statusCode: 503)) },
            createUser: { _, _ in fatalError("Not implemented") },
            signIn: { _, _ in fatalError("Not implemented") }
        )
        
        let sut = NetworkService(dependencies)
        
        // when - проверка
        await #expect(performing: sut.fetchTop, throws: { error in
            // then - проверяем тип и содержание ошибки
            guard let networkErr = error as? NetworkError else {
                throw NSError(domain: "test", code: 1, userInfo: ["message": "Unexpected error type"])
            }
            return networkErr == .serviceUnavailable
        })
    }
    
    @Test
    func fetchTop_emptyData() async throws {
        // given - дано
        let dependencies = NetworkService.Dependencies(
            request: { req in (Data(), makeResponse(req)) },
            createUser: { _, _ in fatalError("Not implemented") },
            signIn: { _, _ in fatalError("Not implemented") }
        )
        
        let sut = NetworkService(dependencies)
        
        // when - взаимодействие
        await #expect(performing: sut.fetchTop, throws: { error in
            // then - проверка результата
            guard let networkErr = error as? NetworkError else {
                throw NSError(domain: "test", code: 1)
            }
            return networkErr == .noData
        })
    }
    
    @Test
    func fetchTop_requestThrowError() async throws {
        // given - дано
        let dependencies = NetworkService.Dependencies(
            request: { _ in throw URLError(.badURL) },
            createUser: { _, _ in fatalError("Not implemented") },
            signIn: { _, _ in fatalError("Not implemented") }
        )
        
        let sut = NetworkService(dependencies)
        
        // when - взаимодействие
        await #expect(performing: sut.fetchTop, throws: { error in
            // then - проверка результата
            error is URLError
        })
    }
    func makeResponse(_ req: URLRequest, statusCode: Int = 200) -> URLResponse {
        HTTPURLResponse(
            url: req.url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
    
//    @Test
//    func createUser() async throws {
//        // given
//        let expected = NetworkServiceTests.user
//        let sut = NetworkService(
//            .init(request: { _ in
//                fatalError("Not implemented")
//            }, createUser: { _, _ in
//                expected
//            }, signIn: { _, _ in
//                fatalError("Not implemented")
//            })
//        )
//        //when
//        let user = await sut.signUp(with: NetworkServiceTests.credentials)
//        
//        switch user {
//        case .success(let user):
//          
//            #expect(user.email == expected.email)
//          case .failure(let error):
//              print("Sign-up failed with error: \(error)")
//              throw NSError(domain: "tests", code: 1)
//          }
//    }
    
    @Test
    func loginUser() async throws {
        // given
        let expected = NetworkServiceTests.user
        let sut = NetworkService(
            .init(request: { _ in
                fatalError("Not implemented")
            }, createUser: { _, _ in
                fatalError("Not implemented")
            }, signIn: { _, _ in
                expected
            })
        )
        //when
        let user = await sut.signIn(with: NetworkServiceTests.credentials)
        
        switch user {
        case .success(let user):
          
            #expect(user.email  == expected.email)
          case .failure(let error):
              print("Sign-up failed with error: \(error)")
              throw NSError(domain: "tests", code: 1)
          }
    }
}
