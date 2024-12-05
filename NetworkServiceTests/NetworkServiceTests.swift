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
    
    //MARK: - StationDataService test
    @Test
    func fetchTop_success() async throws {
        // given - дано
        let expected = [Station()]
        let data = try JSONEncoder().encode(expected)
        let sut = NetworkService { req in
            (data, makeResponse(req))
        }
        
        // when - взаимодействие
        let stations = try await sut.fetchTop()
        
        // then - проверка результата
        #expect(stations == expected)
    }
    
    @Test
    func fetchTop_badStatusCode() async throws {
        
        // given - дано
        let sut = NetworkService { req in
            (Data(), makeResponse(req, statusCode: 400))
        }
        
        // when - взаимодействие
        await #expect(performing: sut.fetchTop, throws: { error in
            // then - проверка результата
            guard let networkErr = error as? NetworkError else {
                throw NSError(domain: "test", code: 1)
            }
            return networkErr == NetworkError.serverError(
                statusCode: 400,
                message: "Server error occurred"
            )
        })
    }
    
    @Test func fetchTop_emptyData() async throws {
        
        // given - дано
        let sut = NetworkService { req in
            (Data(), makeResponse(req))
        }
        
        // when - взаимодействие
        await #expect(performing: sut.fetchTop, throws: { error in
            // then - проверка результата
            guard let networkErr = error as? NetworkError else {
                throw NSError(domain: "test", code: 1)
            }
            return networkErr == .noData
        })
    }
    
    @Test func fetchTop_requestThrowError() async throws {
       
        // given - дано
        let sut = NetworkService { _ in
            throw URLError(.badURL)
        }
        
        // when - взаимодействие
        await #expect(performing: sut.fetchTop, throws: { error in
            // then - проверка результата
            error is URLError
        })
    }
}

private extension NetworkServiceTests {
    
    func makeResponse(_ req: URLRequest, statusCode: Int = 200) -> URLResponse {
        HTTPURLResponse(
            url: req.url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
