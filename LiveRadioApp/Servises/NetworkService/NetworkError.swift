//
//  NetworkError.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int, message: String)
    case unknown(Error)
    
    @inlinable
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
