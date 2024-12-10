//
//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by Daniil Murzin on 03.12.2024.
//

import Testing
import Foundation
import FirebaseAuth

@testable import LiveRadioApp

struct NetworkServiceTests {
    
    let userMock = UserMock(uid: "123", email: "test@example.com")
//    lazy var authResultMock = AuthDataResultMock(user: userMock)
    
    //MARK: - StationDataService tests
    @Test
    func fetchTop_success() async throws {
        // given - дано
        let expected = [Station()]
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
        let expected = [Station()]
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
//    func signUp_success() async throws {
//         // given - дано
//         guard let email = Email("test@example.com"),
//               let password = Password("password123") else {
//             #expect(false, "Failed to create valid Email or Password")
//             return
//         }
//         
//         let credentials = Credentials(email: email, password: password)
//         let expectedUser = User(id: userMock.uid, email: userMock.email ?? "")
//
////         let authResultMock = AuthDataResultMock(user: userMock)
//         
//         let dependencies = NetworkService.Dependencies(
//             request: { _ in fatalError("Not implemented") },
//             createUser: { email, password in
//                 return authResultMock
//             signIn: { _, _ in fatalError("Not implemented") }
//         )
//         
//         let sut = NetworkService(dependencies)
//         
//         // when - взаимодействие
//         let result = await sut.signUp(with: credentials)
//         
//         // then - проверка результата
//         switch result {
//         case .success(let user):
//             #expect(user == expectedUser, "The returned user does not match the expected user")
//         case .failure(let error):
//             throw NSError(domain: "test", code: 1, userInfo: ["message": "Unexpected failure: \(error)"])
//         }
//     }
//    
    //Когда замыкание захватывает self, а self — это изменяемая структура (struct), Swift запрещает такие действия. Это связано с тем, что структуры в Swift являются значимыми типами, и замыкание может захватить устаревшую копию self.
}
