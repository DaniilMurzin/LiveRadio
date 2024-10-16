//
//  Endpoint.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//


import Foundation

enum Endpoint {
    case popular
    
    var path: String {
        switch self {
        case .popular:
            return "/json/stations/topvote"
        }
    }
}
