//
//  NetworkError.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
