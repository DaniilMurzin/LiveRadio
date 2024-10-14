//
//  Endpoint.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//


import Foundation

enum Endpoint {
    case popular
    
    /// Возвращает путь конечной точки в зависимости от выбранного запроса.
    var path: String {
        switch self {
        case .popular:
            return "/recipes/complexSearch"
            
        }
    }
}
